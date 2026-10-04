// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppFontSize {
  static const double xxSmall = 10.0;
  static const double xSmall = 12.0;
  static const double small = 14.0;
  static const double medium = 16.0;
  static const double xMed = 18.0;
  static const double large = 20.0;
  static const double xLarge = 24.0;
}

class AppStyles extends TextTheme {
  const AppStyles._({
    super.headlineLarge,
    super.headlineMedium,
    super.headlineSmall,
    super.bodyLarge,
    super.bodyMedium,
    super.bodySmall,
    super.titleLarge,
    super.titleMedium,
    super.titleSmall,
    super.labelLarge,
    super.labelMedium,
    super.labelSmall,
    super.displayLarge,
    super.displayMedium,
    super.displaySmall,
    required this.headings,
    required this.body,
  });

  final _AppHeadingStyles headings;

  final _AppBodyStyles body;

  factory AppStyles.fromTextTheme({required TextTheme textTheme}) => AppStyles._(
        headlineSmall: textTheme.headlineSmall,
        headlineMedium: textTheme.headlineMedium,
        headlineLarge: textTheme.headlineLarge,
        bodyLarge: textTheme.bodyLarge,
        bodyMedium: textTheme.bodyMedium,
        bodySmall: textTheme.bodySmall,
        titleLarge: textTheme.titleLarge,
        titleMedium: textTheme.titleMedium,
        titleSmall: textTheme.titleSmall,
        labelLarge: textTheme.labelLarge,
        labelMedium: textTheme.labelMedium,
        labelSmall: textTheme.labelSmall,
        displayLarge: textTheme.displayLarge,
        displayMedium: textTheme.displayMedium,
        displaySmall: textTheme.displaySmall,
        headings: _AppHeadingStyles.build(),
        body: _AppBodyStyles.build(),
      );

  /// `.spMin` keeps text from ballooning on tablets while still shrinking on
  /// small phones.
  static AppStyles getAppStyles(TextTheme textTheme, Color displayColor, Color bodyColor) {
    return AppStyles.fromTextTheme(
      textTheme: textTheme
          .copyWith(
            displayLarge: textTheme.displayLarge?.copyWith(fontSize: 32.0.spMin, fontWeight: FontWeight.w600),
            displayMedium: textTheme.displayMedium?.copyWith(fontSize: 24.0.spMin, fontWeight: FontWeight.w600),
            displaySmall: textTheme.displaySmall?.copyWith(fontSize: 20.0.spMin, fontWeight: FontWeight.w600),
            //
            headlineLarge: textTheme.headlineLarge?.copyWith(fontSize: 16.0.spMin, fontWeight: FontWeight.w600),
            headlineMedium: textTheme.headlineMedium?.copyWith(fontSize: 14.0.spMin, fontWeight: FontWeight.w600),
            headlineSmall: textTheme.headlineSmall?.copyWith(fontSize: 12.0.spMin, fontWeight: FontWeight.w400),
            //
            titleLarge: textTheme.titleLarge?.copyWith(fontSize: 18.0.spMin, fontWeight: FontWeight.w600),
            titleMedium: textTheme.titleMedium?.copyWith(fontSize: 16.0.spMin, fontWeight: FontWeight.w600),
            titleSmall: textTheme.titleSmall?.copyWith(fontSize: 14.0.spMin, fontWeight: FontWeight.w500),
            //
            labelLarge: textTheme.labelLarge?.copyWith(fontSize: 14.0.spMin, fontWeight: FontWeight.w600),
            labelMedium: textTheme.labelMedium?.copyWith(fontSize: 12.0.spMin, fontWeight: FontWeight.w600),
            labelSmall: textTheme.labelSmall?.copyWith(fontSize: 11.0.spMin, fontWeight: FontWeight.w500),
            //
            bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: 16.0.spMin, fontWeight: FontWeight.w400),
            bodyMedium: textTheme.bodyMedium?.copyWith(fontSize: 14.0.spMin, fontWeight: FontWeight.w400),
            bodySmall: textTheme.bodySmall?.copyWith(fontSize: 12.0.spMin, fontWeight: FontWeight.w400),
          )
          .apply(displayColor: displayColor, bodyColor: bodyColor),
    );
  }
}

@immutable
class _AppHeadingStyles {
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;

  const _AppHeadingStyles._({
    required this.heading1,
    required this.heading2,
    required this.heading3,
  });

  factory _AppHeadingStyles.build() => _AppHeadingStyles._(
        heading1: TextStyle(fontSize: 28.spMin, fontWeight: FontWeight.bold),
        heading2: TextStyle(fontSize: 24.spMin, fontWeight: FontWeight.bold),
        heading3: TextStyle(fontSize: 20.spMin, fontWeight: FontWeight.bold),
      );
}

@immutable
class _AppBodyStyles {
  /// Buttons & emphasised inline text.
  final TextStyle highlightEmphasis;

  /// Small badges (status, urgent).
  final TextStyle caption;

  const _AppBodyStyles._({
    required this.highlightEmphasis,
    required this.caption,
  });

  factory _AppBodyStyles.build() => _AppBodyStyles._(
        highlightEmphasis: TextStyle(fontSize: 15.spMin, fontWeight: FontWeight.w600),
        caption: TextStyle(fontSize: 11.spMin, fontWeight: FontWeight.w600, height: 1.2),
      );
}
