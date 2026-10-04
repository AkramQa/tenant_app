import 'package:flutter/material.dart';

/// An enumeration of language codes and their corresponding properties.
enum LanguageEnum {
  /// English language.
  english('en'),

  /// Arabic language.
  arabic('ar', isRtl: true),
  ;

  const LanguageEnum(
    this.code, {
    this.isRtl = false,
  });

  /// The language code.
  final String code;

  /// A flag indicating whether the language is written from right to left.
  final bool isRtl;

  /// Returns the language as a [Locale] object.
  Locale get asLocale => Locale(code);

  String get translate => this == LanguageEnum.english ? 'English' : 'العربية';

  bool get isArabic => this == LanguageEnum.arabic;

  static LanguageEnum? fromCode(String? code) =>
      LanguageEnum.values.where((language) => language.code == code).firstOrNull;
}
