import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_response_model.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, SignInResponseModel>> signIn({
    required String identifier,
    required String password,
  });

  /// Restores a persisted session; `Right(null)` when signed out.
  Future<Either<Failure, TenantInfoModel?>> getSignedInUserInfo();

  Future<Either<Failure, Unit>> clearCache();
}
