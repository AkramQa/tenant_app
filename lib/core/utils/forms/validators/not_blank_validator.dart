import 'package:reactive_forms/reactive_forms.dart';

/// Like `RequiredValidator`, but also rejects whitespace-only strings.
class NotBlankValidator extends Validator<dynamic> {
  const NotBlankValidator();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final value = control.value;
    if (value is String && value.trim().isEmpty) {
      return <String, dynamic>{ValidationMessage.required: true};
    }
    return null;
  }
}
