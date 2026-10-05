import 'package:dartz/dartz.dart' show Either, Unit, right, unit;
import 'package:logger/logger.dart';
import 'package:tenant_app/core/data/repositories/base_repository_impl.dart';
import 'package:tenant_app/core/data/utils/network/network_info.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/network/network_info.dart';
import 'package:tenant_app/features/auth/data/datasources/local/authentication_local_source.dart';
import 'package:tenant_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_response_model.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';
import 'package:tenant_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tenant_app/core/di/app_providers.dart';

final authRepositoryOverride = authRepositoryProvider.overrideWith(
  (ref) => AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(authenticationLocalSourceProvider),
    ref.watch(networkInfoProvider),
    ref.watch(loggerProvider),
  ),
);

class AuthRepositoryImpl extends BaseRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthenticationLocalSource local;

  AuthRepositoryImpl(this.remote, this.local, NetworkInfo networkInfo, Logger logger) : super(networkInfo, logger);

  @override
  Future<Either<Failure, SignInResponseModel>> signIn({
    required String identifier,
    required String password,
  }) {
    return request(() async {
      final response = await remote.signIn(identifier: identifier, password: password);
      final SignInResponseModel signInResponse = response.requireData;
      await local.saveAccessToken(signInResponse.accessToken);
      await local.signInUser(signInResponse.tenant);
      return right(signInResponse);
    });
  }

  @override
  Future<Either<Failure, TenantInfoModel?>> getSignedInUserInfo() {
    return localRequest(() async {
      final String? accessToken = await local.getAccessToken();
      if (accessToken == null) return right(null);
      return right(local.getSignedInUserInfo());
    });
  }

  @override
  Future<Either<Failure, Unit>> clearCache() {
    return localRequest(() async {
      await local.deleteAccessToken();
      await local.deleteSignedInUserInfo();
      return right(unit);
    });
  }
}
