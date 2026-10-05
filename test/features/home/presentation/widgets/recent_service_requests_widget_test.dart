import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/home/presentation/widgets/recent_service_requests_widget.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/service_request_card_widget.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/mocks.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late MockServiceRequestsRepository repository;
  late ProviderContainer container;

  setUpAll(() => registerFallbackValue(<ServiceRequestModel>[]));

  setUp(() {
    repository = MockServiceRequestsRepository();
    when(() => repository.fetchCachedServiceRequests()).thenAnswer((_) async => const Right(null));
    when(() => repository.cacheServiceRequests(serviceRequests: any(named: 'serviceRequests')))
        .thenAnswer((_) async => const Right(true));
    container = ProviderContainer(overrides: [serviceRequestsRepositoryProvider.overrideWithValue(repository)]);
  });

  tearDown(() => container.dispose());

  // Loaded before pumping: the loading shimmer animates forever and would block pumpAndSettle.
  Future<void> pumpWithRemote(WidgetTester tester, Either<Failure, List<ServiceRequestModel>> result) async {
    when(() => repository.fetchServiceRequests()).thenAnswer((_) async => result);
    await container.read(serviceRequestsListProvider.notifier).fetchServiceRequests();
    await tester.pumpApp(
      const Scaffold(body: SingleChildScrollView(child: RecentServiceRequestsWidget())),
      container: container,
    );
  }

  testWidgets('shows at most 3 recent requests', (tester) async {
    await pumpWithRemote(tester, Right([for (int i = 0; i < 5; i++) fakeServiceRequestModel(id: 'request-$i')]));

    expect(find.byType(ServiceRequestCardWidget), findsNWidgets(3));
  });

  testWidgets('shows the empty state with a call to action', (tester) async {
    await pumpWithRemote(tester, const Right([]));

    expect(find.text('No service requests yet'), findsOneWidget);
    expect(find.text('New request'), findsOneWidget);
  });

  testWidgets('shows an error with retry when loading fails', (tester) async {
    await pumpWithRemote(tester, const Left(ServerFailure(errorCode: ServerErrorCode.noInternetConnection)));

    expect(find.byType(ServiceRequestCardWidget), findsNothing);
    expect(find.text('Try again'), findsOneWidget);
  });
}
