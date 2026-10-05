import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_app/core/data/utils/configuration.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/network/mock/mock_backend_interceptor.dart';
import 'package:tenant_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:tenant_app/features/auth/data/datasources/remote/mock/auth_mock_server.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_type.dart';
import 'package:tenant_app/features/service_requests/data/datasources/remote/mock/service_requests_mock_server.dart';
import 'package:tenant_app/features/service_requests/data/datasources/remote/service_requests_remote_datasource.dart';
import 'package:tenant_app/features/service_requests/data/models/create_service_request_body_model.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/mocks.dart';

/// Retrofit clients → Dio → MockBackendInterceptor → mock servers, end to end.
void main() {
  late MockNetworkInfo networkInfo;
  late AuthRemoteDataSource auth;
  late ServiceRequestsRemoteDataSource serviceRequests;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    networkInfo = MockNetworkInfo();
    when(() => networkInfo.isConnected).thenAnswer((_) async => true);
    final dio = Dio(BaseOptions(validateStatus: (code) => code != null && code >= 200 && code < 300))
      ..interceptors.add(
        MockBackendInterceptor(
          networkInfo,
          [AuthMockServer(), ServiceRequestsMockServer(await SharedPreferences.getInstance(), const Uuid())],
          latency: Duration.zero,
        ),
      );
    final configuration = DevConfiguration();
    auth = AuthRemoteDataSourceImpl(dio, configuration);
    serviceRequests = ServiceRequestsRemoteDataSourceImpl(dio, configuration);
  });

  group('POST /auth/sign-in', () {
    test('signs in the demo account by phone number', () async {
      final response = await auth.signIn(identifier: '+971 50 123 4567', password: kDemoPassword);

      expect(response.data!.signInType, SignInType.phoneNumber);
      expect(response.data!.tenant.unitNumber, 'B-1204');
    });

    test('rejects a wrong password with 422', () async {
      await expectLater(
        auth.signIn(identifier: kDemoEmail, password: 'wrong'),
        throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'statusCode', 422)),
      );
    });
  });

  group('/service-requests', () {
    test('lists the seeded requests', () async {
      final response = await serviceRequests.fetchServiceRequests();

      expect(response.data, hasLength(4));
    });

    test('creates a pending request that details can then fetch', () async {
      final created = await serviceRequests.createServiceRequest(
        body: CreateServiceRequestBodyModel(
          serviceType: ServiceType.cleaning,
          description: 'Deep clean the kitchen',
          preferredDate: DateTime(2026, 10, 10),
          isUrgent: true,
        ),
      );

      expect(created.data!.status, RequestStatus.pending);
      final details = await serviceRequests.fetchServiceRequestDetails(requestId: created.data!.id);
      expect(details.data!.description, 'Deep clean the kitchen');
      expect(details.data!.isUrgent, isTrue);
    });

    test('returns 404 for an unknown request', () async {
      await expectLater(
        serviceRequests.fetchServiceRequestDetails(requestId: 'missing'),
        throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'statusCode', 404)),
      );
    });
  });

  test('fails like a dropped connection when offline', () async {
    when(() => networkInfo.isConnected).thenAnswer((_) async => false);

    await expectLater(
      serviceRequests.fetchServiceRequests(),
      throwsA(isA<DioException>().having((e) => e.type, 'type', DioExceptionType.connectionError)),
    );
  });
}
