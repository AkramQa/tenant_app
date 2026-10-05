import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tenant_app/core/data/models/base_response.dart';
import 'package:tenant_app/core/data/utils/configuration.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_response_model.dart';
import 'package:tenant_app/core/di/app_providers.dart';

part 'auth_remote_datasource.g.dart';

abstract class AuthRemoteDataSource {
  /// [identifier] is an email address or a phone number.
  Future<BaseResponse<SignInResponseModel>> signIn({
    required String identifier,
    required String password,
  });
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(ref.watch(dioProvider), ref.watch(configurationProvider)),
);

@RestApi(baseUrl: '')
abstract class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  factory AuthRemoteDataSourceImpl(Dio dio, Configuration configuration) {
    return _AuthRemoteDataSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @override
  @POST('/auth/sign-in')
  Future<BaseResponse<SignInResponseModel>> signIn({
    @Field() required String identifier,
    @Field() required String password,
  });
}
