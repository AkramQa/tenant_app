import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_request_details/service_request_details_notifier.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/mocks.dart';

void main() {
  const String requestId = 'request-001';
  const offlineFailure = ServerFailure(errorCode: ServerErrorCode.noInternetConnection);

  late MockServiceRequestsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = MockServiceRequestsRepository();
    container = ProviderContainer(overrides: [serviceRequestsRepositoryProvider.overrideWithValue(repository)]);
    // Keep the autoDispose family alive for the whole test.
    container.listen(serviceRequestDetailsProvider(requestId), (_, __) {});
  });

  tearDown(() => container.dispose());

  Future<ServiceRequestDetailsState> fetch() async {
    await container.read(serviceRequestDetailsProvider(requestId).notifier).fetchServiceRequestDetails();
    return container.read(serviceRequestDetailsProvider(requestId));
  }

  test('shows the request returned by the server', () async {
    final request = fakeServiceRequestModel(id: requestId);
    when(() => repository.fetchServiceRequestDetails(requestId: requestId)).thenAnswer((_) async => Right(request));

    final state = await fetch();

    expect(state, isA<ServiceRequestDetailsSuccessful>());
    final success = state as ServiceRequestDetailsSuccessful;
    expect(success.serviceRequest, request);
    expect(success.isFromCache, isFalse);
  });

  test('falls back to the cached copy when offline', () async {
    final cached = fakeServiceRequestModel(id: requestId);
    when(() => repository.fetchServiceRequestDetails(requestId: requestId))
        .thenAnswer((_) async => const Left(offlineFailure));
    when(() => repository.fetchCachedServiceRequests())
        .thenAnswer((_) async => Right([fakeServiceRequestModel(id: 'other'), cached]));

    final state = await fetch();

    final success = state as ServiceRequestDetailsSuccessful;
    expect(success.serviceRequest, cached);
    expect(success.isFromCache, isTrue);
  });

  test('fails when offline and the request is not cached', () async {
    when(() => repository.fetchServiceRequestDetails(requestId: requestId))
        .thenAnswer((_) async => const Left(offlineFailure));
    when(() => repository.fetchCachedServiceRequests()).thenAnswer((_) async => const Right(null));

    final state = await fetch();

    expect(state, isA<ServiceRequestDetailsFailure>());
  });

  test('does not use the cache for non-connectivity failures', () async {
    when(() => repository.fetchServiceRequestDetails(requestId: requestId))
        .thenAnswer((_) async => const Left(ServerFailure(errorCode: ServerErrorCode.notFound)));

    final state = await fetch();

    expect(state, isA<ServiceRequestDetailsFailure>());
    verifyNever(() => repository.fetchCachedServiceRequests());
  });
}
