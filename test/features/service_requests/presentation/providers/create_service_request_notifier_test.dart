import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/data/repositories/service_requests_repository_impl.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/create_service_request/create_service_request_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/ui-models/create_service_request_input.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/mocks.dart';

void main() {
  late MockServiceRequestsRepository repository;
  late ProviderContainer container;
  late List<CreateServiceRequestState> states;

  final input = CreateServiceRequestInput(
    serviceType: ServiceType.plumbing,
    description: '  Water leaking under the sink  ',
    preferredDate: DateTime(2026, 10, 10),
    isUrgent: true,
  );

  setUpAll(() {
    registerFallbackValue(<ServiceRequestModel>[]);
    registerFallbackValue(ServiceType.unknown);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = MockServiceRequestsRepository();
    when(() => repository.cacheServiceRequests(serviceRequests: any(named: 'serviceRequests')))
        .thenAnswer((_) async => const Right(true));
    container = ProviderContainer(overrides: [serviceRequestsRepositoryProvider.overrideWithValue(repository)]);
    states = [];
    container.listen<CreateServiceRequestState>(createServiceRequestProvider, (_, state) => states.add(state));
  });

  tearDown(() => container.dispose());

  void arrangeCreate(Either<Failure, ServiceRequestModel> result) => when(
        () => repository.createServiceRequest(
          serviceType: any(named: 'serviceType'),
          description: any(named: 'description'),
          preferredDate: any(named: 'preferredDate'),
          isUrgent: any(named: 'isUrgent'),
          imagePath: any(named: 'imagePath'),
        ),
      ).thenAnswer((_) async => result);

  group('CreateServiceRequestNotifier — createServiceRequest', () {
    test('emits [Loading, Successful] and adds the request to the list', () async {
      arrangeCreate(Right(fakeServiceRequestModel(id: 'created')));

      await container.read(createServiceRequestProvider.notifier).createServiceRequest(input);

      expect(states, [isA<CreateServiceRequestLoading>(), isA<CreateServiceRequestSuccessful>()]);
      final list = container.read(serviceRequestsListProvider) as ServiceRequestsListSuccessful;
      expect(list.serviceRequests.first.id, 'created');
    });

    test('sends a trimmed description', () async {
      arrangeCreate(Right(fakeServiceRequestModel()));

      await container.read(createServiceRequestProvider.notifier).createServiceRequest(input);

      verify(
        () => repository.createServiceRequest(
          serviceType: ServiceType.plumbing,
          description: 'Water leaking under the sink',
          preferredDate: DateTime(2026, 10, 10),
          isUrgent: true,
          imagePath: null,
        ),
      ).called(1);
    });

    test('emits [Loading, Failure] and leaves the list untouched on error', () async {
      arrangeCreate(const Left(ServerFailure(errorCode: ServerErrorCode.noInternetConnection)));

      await container.read(createServiceRequestProvider.notifier).createServiceRequest(input);

      expect(states, [isA<CreateServiceRequestLoading>(), isA<CreateServiceRequestFailure>()]);
      expect(container.read(serviceRequestsListProvider), isA<InitialServiceRequestsList>());
    });
  });
}
