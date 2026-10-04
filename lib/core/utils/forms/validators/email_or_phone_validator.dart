import 'package:reactive_forms/reactive_forms.dart';

final RegExp emailPattern = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
final RegExp phoneNumberPattern = RegExp(r'^\+?\d{7,15}$');
final RegExp _phoneSeparators = RegExp(r'[\s\-()]');

/// Accepts a valid email address **or** a phone number (7–15 digits,
/// optional leading `+`, spaces/dashes/brackets ignored).
class EmailOrPhoneValidator extends Validator<dynamic> {
  const EmailOrPhoneValidator();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final String value = control.value?.toString().trim() ?? '';
    if (value.isEmpty) return null; // RequiredValidator handles empty values.

    final bool isEmail = emailPattern.hasMatch(value);
    final bool isPhone = phoneNumberPattern.hasMatch(value.replaceAll(_phoneSeparators, ''));

    return isEmail || isPhone ? null : <String, dynamic>{ValidationMessage().emailOrPhone: true};
  }
}

extension EmailOrPhoneValidation on ValidationMessage {
  String get emailOrPhone => 'email-or-phone';
}
