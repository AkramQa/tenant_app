import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/utils/forms/validators/email_or_phone_validator.dart';

void main() {
  FormControl<String> buildControl(String value) =>
      FormControl<String>(value: value, validators: [const EmailOrPhoneValidator()]);

  group('EmailOrPhoneValidator', () {
    const validValues = [
      'tenant@demo.com',
      'first.last+tag@sub.domain.ae',
      '0501234567',
      '+971 50 123 4567',
      '050-123-4567',
    ];
    for (final value in validValues) {
      test('accepts "$value"', () {
        expect(buildControl(value).hasError(ValidationMessage().emailOrPhone), isFalse);
      });
    }

    const invalidValues = ['tenant@', 'not an email', '12345', 'abc123@', '+97150abc'];
    for (final value in invalidValues) {
      test('rejects "$value"', () {
        expect(buildControl(value).hasError(ValidationMessage().emailOrPhone), isTrue);
      });
    }

    test('leaves empty values to RequiredValidator', () {
      expect(buildControl('').hasError(ValidationMessage().emailOrPhone), isFalse);
    });
  });
}
