import 'package:flutter/material.dart';
import 'package:tenant_app/core/theme/app_breakpoints.dart';
import 'package:tenant_app/core/theme/app_colors.dart';
import 'package:tenant_app/core/theme/app_theme.dart';
import 'package:tenant_app/core/theme/dimensions.dart';
import 'package:tenant_app/core/theme/text_styles.dart';
import 'package:tenant_app/gen/localizations_generated/l10n.dart';

extension BuildContextExt on BuildContext {
  //* THEME *//

  /// Returns the [ThemeData] of the current [BuildContext].
  ThemeData get theme => Theme.of(this);

  /// Returns the [AppStyles] of the current [BuildContext].
  AppStyles get textTheme => theme.textStyles;

  /// Returns the [AppColors] of the current [BuildContext].
  AppColors get colors => theme.colors;

  //* TYPOGRAPHY *//

  TextStyle? get displayLarge => textTheme.displayLarge;

  TextStyle? get displayMedium => textTheme.displayMedium;

  TextStyle? get displaySmall => textTheme.displaySmall;

  TextStyle? get headlineLarge => textTheme.headlineLarge;

  TextStyle? get headlineMedium => textTheme.headlineMedium;

  TextStyle? get headlineSmall => textTheme.headlineSmall;

  TextStyle? get titleLarge => textTheme.titleLarge;

  TextStyle? get titleMedium => textTheme.titleMedium;

  TextStyle? get titleSmall => textTheme.titleSmall;

  TextStyle? get labelLarge => textTheme.labelLarge;

  TextStyle? get labelMedium => textTheme.labelMedium;

  TextStyle? get labelSmall => textTheme.labelSmall;

  TextStyle? get bodyLarge => textTheme.bodyLarge;

  TextStyle? get bodyMedium => textTheme.bodyMedium;

  TextStyle? get bodySmall => textTheme.bodySmall;

  // DIMENSION
  /// Accesses the dimensions defined in the app's theme.
  AppDimens get dimens => theme.dimensions;

  //* MEDIA QUERY *//

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get fullWidth => MediaQuery.sizeOf(this).width;

  double get fullHeight => MediaQuery.sizeOf(this).height;

  /// Tablet / landscape layout: navigation rail, multi-column grids.
  bool get isWideLayout => fullWidth >= AppBreakpoints.wide;

  //* PLATFORM *//

  bool get isCupertinoPlatform =>
      theme.platform == TargetPlatform.iOS || theme.platform == TargetPlatform.macOS;

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  /// Get translations from context.
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Current locale of the app.
  Locale get locale => Localizations.localeOf(this);
}
