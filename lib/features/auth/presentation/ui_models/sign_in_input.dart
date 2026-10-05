import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/utils/forms/validators/email_or_phone_validator.dart';

part 'sign_in_input.freezed.dart';
part 'sign_in_input.gform.dart';

@freezed
@ReactiveFormAnnotation()
abstract class SignInInput with _$SignInInput {
  factory SignInInput({
    @FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()]) @Default('') String identifier,
    @FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)])
    @Default('')
    String password,
  }) = _SignInInput;
}
