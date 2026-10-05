// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignInResponseModel _$SignInResponseModelFromJson(Map<String, dynamic> json) =>
    _SignInResponseModel(
      accessToken: json['access_token'] as String,
      tenant: TenantInfoModel.fromJson(json['tenant'] as Map<String, dynamic>),
      signInType: SignInTypeConverter.fromJson(json['sign_in_type'] as String?),
    );

Map<String, dynamic> _$SignInResponseModelToJson(
  _SignInResponseModel instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'tenant': instance.tenant,
  'sign_in_type': SignInTypeConverter.toJson(instance.signInType),
};
