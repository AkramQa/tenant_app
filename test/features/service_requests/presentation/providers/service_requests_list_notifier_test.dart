import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/mocks.dart';

void main() {
  late MockServiceRequestsRepository repository;
  late ProviderContainer container;
  late List<ServiceRequestsListState> states;

  const offlineFailure = ServerFailure(errorCode: ServerErrorCode.noInternetConnection);

  setUpAll(() => registerFallbackValue(<ServiceRequestModel>[]));

  setUp(() {
    repository = MockServiceRequestsRepository();
    when(() => repository.cacheServiceRequests(serviceRequests: any(named: 'serviceRequests')))
        .thenAnswer((_) async => const Right(true));
    container = ProviderContainer(overrides: [serviceRequestsRepositoryProvider.overrideWithValue(repository)]);
    states = [];
    container.listen<ServiceRequestsListState>(serviceRequestsListProvider, (_, state) => states.add(state));
  });

  tearDown(() => container.dispose());

  void arrangeCache(List<ServiceRequestModel>? cached) =>
      when(() => repository.fetchCachedServiceRequests()).thenAnswer((_) async => Right(cached));

  void arrangeRemote(Either<Failure, List<ServiceRequestModel>> result) =>
      when(() => repository.fetchServiceRequests()).thenAnswer((_) async => result);

  ServiceRequestsListNotifier notifier() => container.read(serviceRequestsListProvider.notifier);

  group('ServiceRequestsListNotifier — fetchServiceRequests', () {
    test('emits [Loading, Successful] and caches the result when there is no cache', () async {
      final requests = [fakeServiceRequestModel()];
      arrangeCache(null);
      arrangeRemote(Right(requests));

      await notifier().fetchServiceRequests();

      expect(states, [isA<ServiceRequestsListLoading>(), isA<ServiceRequestsListSuccessful>()]);
      final success = states.last as ServiceRequestsListSuccessful;
      expect(success.serviceRequests, requests);
      expect(success.isFromCache, isFalse);
      verify(() => repository.cacheServiceRequests(serviceRequests: requests)).called(1);
    });

    test('shows cached data first, then fresh data', () async {
      arrangeCache([fakeServiceRequestModel(id: 'cached')]);
      arrangeRemote(Right([fakeServiceRequestModel(id: 'fresh')]));

      await notifier().fetchServiceRequests();

      final first = states.first as ServiceRequestsListSuccessful;
      final last = states.last as ServiceRequestsListSuccessful;
      expect(first.isFromCache, isTrue);
      expect(first.serviceRequests.single.id, 'cached');
      expect(last.isFromCache, isFalse);
      expect(last.serviceRequests.single.id, 'fresh');
    });

    test('keeps cached data and exposes refreshFailure when offline', () async {
      arrangeCache([fakeServiceRequestModel(id: 'cached')]);
      arrangeRemote(const Left(offlineFailure));

      await notifier().fetchServiceRequests();

      final last = states.last as ServiceRequestsListSuccessful;
      expect(last.serviceRequests.single.id, 'cached');
      expect(last.isFromCache, isTrue);
      expect(last.refreshFailure, offlineFailure);
    });

    test('emits Failure when offline and nothing is cached', () async {
      arrangeCache(null);
      arrangeRemote(const Left(offlineFailure));

      await notifier().fetchServiceRequests();

      expect(states, [isA<ServiceRequestsListLoading>(), isA<ServiceRequestsListFailure>()]);
    });
  });

  test('addCreatedServiceRequest puts the new request first', () async {
    arrangeCache(null);
    arrangeRemote(Right([fakeServiceRequestModel(id: 'existing')]));
    await notifier().fetchServiceRequests();

    notifier().addCreatedServiceRequest(fakeServiceRequestModel(id: 'new'));

    final last = states.last as ServiceRequestsListSuccessful;
    expect(last.serviceRequests.map((request) => request.id), ['new', 'existing']);
  });
}
