import 'package:equatable/equatable.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_type.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';

class SignInResponseModel extends Equatable {
  final String accessToken;
  final TenantInfoModel tenant;
  final SignInType? signInType;

  const SignInResponseModel({
    required this.accessToken,
    required this.tenant,
    this.signInType,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) => SignInResponseModel(
        accessToken: json['access_token'] as String,
        tenant: TenantInfoModel.fromJson(json['tenant'] as Map<String, dynamic>),
        signInType: SignInTypeConverter.fromJson(json['sign_in_type'] as String?),
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'tenant': tenant.toJson(),
        'sign_in_type': SignInTypeConverter.toJson(signInType),
      };

  @override
  List<Object?> get props => [accessToken, tenant, signInType];
}
