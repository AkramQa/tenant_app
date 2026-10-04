import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/utils/forms/validators/email_or_phone_validator.dart';

class SignInInput {
  final String identifier;
  final String password;

  SignInInput({this.identifier = '', this.password = ''});
}

/// Typed access to the sign-in [FormGroup] (the shape `reactive_forms_generator`
/// produces in the reference codebase, written by hand so the project needs
/// no code generation).
class SignInInputForm {
  SignInInputForm(this.form);

  final FormGroup form;

  static const String identifierControlName = 'identifier';
  static const String passwordControlName = 'password';

  static FormGroup buildFormGroup([SignInInput? model]) => FormGroup({
        identifierControlName: FormControl<String>(
          value: model?.identifier ?? '',
          validators: [Validators.required, const EmailOrPhoneValidator()],
        ),
        passwordControlName: FormControl<String>(
          value: model?.password ?? '',
          validators: [Validators.required, Validators.minLength(kMinPasswordLength)],
        ),
      });

  FormControl<String> get identifierControl => form.control(identifierControlName) as FormControl<String>;

  FormControl<String> get passwordControl => form.control(passwordControlName) as FormControl<String>;

  SignInInput get model => SignInInput(
        identifier: identifierControl.value ?? '',
        password: passwordControl.value ?? '',
      );

  void identifierValueUpdate(String value) => identifierControl.updateValue(value);

  void passwordValueUpdate(String value) => passwordControl.updateValue(value);
}
