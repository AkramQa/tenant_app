import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/data/utils/exception.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/data/repositories/service_requests_repository_impl.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/mocks.dart';

void main() {
  late MockServiceRequestsRemoteDataSource remote;
  late MockServiceRequestsLocalDataSource local;
  late ServiceRequestsRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(ServiceType.unknown);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    remote = MockServiceRequestsRemoteDataSource();
    local = MockServiceRequestsLocalDataSource();
    repository = ServiceRequestsRepositoryImpl(remote, local, MockNetworkInfo(), Logger(level: Level.off));
    when(() => local.resolveAttachmentPath(any())).thenAnswer((invocation) {
      final fileName = invocation.positionalArguments.first as String?;
      return fileName == null ? null : '/documents/attachments/$fileName';
    });
  });

  group('ServiceRequestsRepositoryImpl — fetchServiceRequests', () {
    test('returns requests newest first with resolved image paths', () async {
      final older = fakeServiceRequestModel(id: 'older', createdAt: DateTime(2026, 9, 1));
      final newer = fakeServiceRequestModel(id: 'newer', createdAt: DateTime(2026, 10, 1), imageFileName: 'a.jpg');
      when(() => remote.fetchServiceRequests()).thenAnswer((_) async => [older, newer]);

      final result = await repository.fetchServiceRequests();

      final requests = result.getOrElse(() => []);
      expect(requests.map((request) => request.id), ['newer', 'older']);
      expect(requests.first.localImagePath, '/documents/attachments/a.jpg');
    });

    test('maps an offline ServerException to a noInternetConnection failure', () async {
      when(() => remote.fetchServiceRequests())
          .thenThrow(const ServerException(errorCode: ServerErrorCode.noInternetConnection));

      final result = await repository.fetchServiceRequests();

      expect(result, const Left(ServerFailure(errorCode: ServerErrorCode.noInternetConnection)));
    });
  });

  group('ServiceRequestsRepositoryImpl — createServiceRequest', () {
    test('stores the attachment and sends its file name to the API', () async {
      when(() => local.saveAttachment(sourcePath: '/tmp/picked.jpg')).thenAnswer((_) async => 'stored.jpg');
      when(
        () => remote.createServiceRequest(
          serviceType: any(named: 'serviceType'),
          description: any(named: 'description'),
          preferredDate: any(named: 'preferredDate'),
          isUrgent: any(named: 'isUrgent'),
          imageFileName: any(named: 'imageFileName'),
        ),
      ).thenAnswer((_) async => fakeServiceRequestModel(id: 'new', imageFileName: 'stored.jpg'));

      final result = await repository.createServiceRequest(
        serviceType: ServiceType.plumbing,
        description: 'Leaking sink',
        preferredDate: DateTime(2026, 10, 10),
        isUrgent: true,
        imagePath: '/tmp/picked.jpg',
      );

      expect(result.isRight(), isTrue);
      verify(
        () => remote.createServiceRequest(
          serviceType: ServiceType.plumbing,
          description: 'Leaking sink',
          preferredDate: DateTime(2026, 10, 10),
          isUrgent: true,
          imageFileName: 'stored.jpg',
        ),
      ).called(1);
    });

    test('maps a local CacheException to a LogicFailure without calling the API', () async {
      when(() => local.saveAttachment(sourcePath: any(named: 'sourcePath')))
          .thenThrow(const CacheException('disk full'));

      final result = await repository.createServiceRequest(
        serviceType: ServiceType.cleaning,
        description: 'Deep clean',
        preferredDate: DateTime(2026, 10, 10),
        isUrgent: false,
        imagePath: '/tmp/picked.jpg',
      );

      expect(result.isLeft(), isTrue);
      verifyNever(
        () => remote.createServiceRequest(
          serviceType: any(named: 'serviceType'),
          description: any(named: 'description'),
          preferredDate: any(named: 'preferredDate'),
          isUrgent: any(named: 'isUrgent'),
          imageFileName: any(named: 'imageFileName'),
        ),
      );
    });
  });

  test('fetchCachedServiceRequests returns Right(null) when nothing is cached', () async {
    when(() => local.fetchCachedServiceRequests()).thenAnswer((_) async => null);

    final result = await repository.fetchCachedServiceRequests();

    expect(result, const Right(null));
  });
}
