import 'package:dartz/dartz.dart' show Left, Right;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/data/models/base_response.dart';
import 'package:tenant_app/core/data/utils/exception.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/service_requests/data/models/create_service_request_body_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/data/repositories/service_requests_repository_impl.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/mocks.dart';

void main() {
  late MockServiceRequestsRemoteDataSource remote;
  late MockServiceRequestsLocalDataSource local;
  late ServiceRequestsRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
      CreateServiceRequestBodyModel(serviceType: ServiceType.unknown, description: '', preferredDate: DateTime(2026)),
    );
  });

  DioException offline() => DioException.connectionError(requestOptions: RequestOptions(), reason: 'Offline');

  setUp(() {
    remote = MockServiceRequestsRemoteDataSource();
    local = MockServiceRequestsLocalDataSource();
    repository = ServiceRequestsRepositoryImpl(remote, local, Logger(level: Level.off));
    when(() => local.resolveAttachmentPath(any())).thenAnswer((invocation) {
      final fileName = invocation.positionalArguments.first as String?;
      return fileName == null ? null : '/documents/attachments/$fileName';
    });
  });

  group('ServiceRequestsRepositoryImpl — fetchServiceRequests', () {
    test('returns requests newest first with resolved image paths', () async {
      final older = fakeServiceRequestModel(id: 'older', createdAt: DateTime(2026, 9, 1));
      final newer = fakeServiceRequestModel(id: 'newer', createdAt: DateTime(2026, 10, 1), imageFileName: 'a.jpg');
      when(() => remote.fetchServiceRequests()).thenAnswer((_) async => BaseResponse(data: [older, newer]));

      final result = await repository.fetchServiceRequests();

      final requests = result.getOrElse(() => []);
      expect(requests.map((request) => request.id), ['newer', 'older']);
      expect(requests.first.localImagePath, '/documents/attachments/a.jpg');
    });

    test('maps a Dio connection error to a noInternetConnection failure', () async {
      when(
        () => remote.fetchServiceRequests(),
      ).thenThrow(offline());

      final result = await repository.fetchServiceRequests();

      expect(result, const Left(ServerFailure(errorCode: ServerErrorCode.noInternetConnection)));
    });
  });

  test('maps an HTTP 404 with an envelope to a notFound failure', () async {
    final options = RequestOptions(path: '/service-requests/missing');
    when(() => remote.fetchServiceRequestDetails(requestId: 'missing')).thenThrow(
      DioException.badResponse(
        statusCode: 404,
        requestOptions: options,
        response: Response(requestOptions: options, statusCode: 404, data: {'message': 'Not found'}),
      ),
    );

    final result = await repository.fetchServiceRequestDetails(requestId: 'missing');

    expect(result, const Left(ServerFailure(errorCode: ServerErrorCode.notFound, message: 'Not found')));
  });

  test('maps a success response without data to a serverError failure', () async {
    when(() => remote.fetchServiceRequests()).thenAnswer((_) async => BaseResponse());

    final result = await repository.fetchServiceRequests();

    expect(result, const Left(ServerFailure(errorCode: ServerErrorCode.serverError)));
  });

  group('ServiceRequestsRepositoryImpl — createServiceRequest', () {
    test('stores the attachment and sends its file name to the API', () async {
      when(() => local.saveAttachment(sourcePath: '/tmp/picked.jpg')).thenAnswer((_) async => 'stored.jpg');
      when(
        () => remote.createServiceRequest(body: any(named: 'body')),
      ).thenAnswer((_) async => BaseResponse(data: fakeServiceRequestModel(id: 'new', imageFileName: 'stored.jpg')));

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
          body: CreateServiceRequestBodyModel(
            serviceType: ServiceType.plumbing,
            description: 'Leaking sink',
            preferredDate: DateTime(2026, 10, 10),
            isUrgent: true,
            imageFileName: 'stored.jpg',
          ),
        ),
      ).called(1);
    });

    test('maps a local CacheException to a CacheFailure without calling the API', () async {
      when(
        () => local.saveAttachment(sourcePath: any(named: 'sourcePath')),
      ).thenThrow(const CacheException('disk full'));

      final result = await repository.createServiceRequest(
        serviceType: ServiceType.cleaning,
        description: 'Deep clean',
        preferredDate: DateTime(2026, 10, 10),
        isUrgent: false,
        imagePath: '/tmp/picked.jpg',
      );

      expect(result.fold((failure) => failure, (_) => null), isA<CacheFailure>());
      verifyNever(
        () => remote.createServiceRequest(body: any(named: 'body')),
      );
    });
  });

  test('createServiceRequest deletes the stored attachment when the API call fails', () async {
    when(() => local.saveAttachment(sourcePath: '/tmp/picked.jpg')).thenAnswer((_) async => 'stored.jpg');
    when(() => local.deleteAttachment(fileName: 'stored.jpg')).thenAnswer((_) async {});
    when(
      () => remote.createServiceRequest(body: any(named: 'body')),
    ).thenThrow(offline());

    final result = await repository.createServiceRequest(
      serviceType: ServiceType.plumbing,
      description: 'Leaking sink',
      preferredDate: DateTime(2026, 10, 10),
      isUrgent: false,
      imagePath: '/tmp/picked.jpg',
    );

    expect(result, const Left(ServerFailure(errorCode: ServerErrorCode.noInternetConnection)));
    verify(() => local.deleteAttachment(fileName: 'stored.jpg')).called(1);
  });

  test('fetchCachedServiceRequests returns Right(null) when nothing is cached', () async {
    when(() => local.fetchCachedServiceRequests()).thenAnswer((_) async => null);

    final result = await repository.fetchCachedServiceRequests();

    expect(result, const Right(null));
  });
}
