import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_type.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';

part 'sign_in_response_model.freezed.dart';

part 'sign_in_response_model.g.dart';

@freezed
class SignInResponseModel with _$SignInResponseModel {
  factory SignInResponseModel({
    required String accessToken,
    required TenantInfoModel tenant,
    @JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson) SignInType? signInType,
  }) = _SignInResponseModel;

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) => _$SignInResponseModelFromJson(json);
}
