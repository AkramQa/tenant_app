import 'package:mocktail/mocktail.dart';
import 'package:tenant_app/core/domain/utils/network/network_info.dart';
import 'package:tenant_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tenant_app/features/service_requests/data/datasources/local/service_requests_local_source.dart';
import 'package:tenant_app/features/service_requests/data/datasources/remote/service_requests_remote_datasource.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockServiceRequestsRepository extends Mock implements ServiceRequestsRepository {}

class MockServiceRequestsRemoteDataSource extends Mock implements ServiceRequestsRemoteDataSource {}

class MockServiceRequestsLocalDataSource extends Mock implements ServiceRequestsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}
