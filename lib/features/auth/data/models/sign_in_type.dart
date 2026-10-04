enum SignInType {
  email('email'),
  phoneNumber('phone_number'),
  unknown('unknown');

  final String value;

  const SignInType(this.value);
}

class SignInTypeConverter {
  const SignInTypeConverter();

  static SignInType fromJson(String? signInTypeAsString) => SignInType.values.firstWhere(
        (type) => type.value == signInTypeAsString,
        orElse: () => SignInType.unknown,
      );

  static String? toJson(SignInType? signInType) => signInType?.value;
}
