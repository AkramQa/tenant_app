import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/data/models/enum/languages_enum.dart';
import 'package:tenant_app/core/theme/app_colors.dart';
import 'package:tenant_app/core/theme/app_radius.dart';
import 'package:tenant_app/core/theme/dimensions.dart';
import 'package:tenant_app/core/theme/text_styles.dart';

late AppDimens _dimensions;
late AppStyles _lightStyles;
late AppStyles _darkStyles;
late AppColors _lightColors;
late AppColors _darkColors;

class AppTheme {
  const AppTheme._();

  static ThemeData provideThemeData(
    BuildContext buildContext, {
    required LanguageEnum language,
    required Brightness brightness,
  }) {
    final baseTheme = ThemeData(brightness: brightness, useMaterial3: true);
    final colors = AppColors.getAppColors(brightness: brightness);
    final styles = AppStyles.getAppStyles(baseTheme.textTheme, colors.cardTitle, colors.onSurface);

    if (brightness == Brightness.light) {
      _lightColors = colors;
      _lightStyles = styles;
    } else {
      _darkColors = colors;
      _darkStyles = styles;
    }
    _dimensions = AppDimens.getDimensions();

    return baseTheme.copyWith(
      colorScheme: colors,
      textTheme: styles,
      primaryColor: colors.primary,
      primaryTextTheme: styles,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: _appBarTheme(colors, styles, brightness),
      cardTheme: _cardTheme(colors),
      listTileTheme: _listTileTheme(colors),
      navigationBarTheme: _navigationBarTheme(colors, styles),
      navigationRailTheme: _navigationRailTheme(colors, styles),
      scaffoldBackgroundColor: colors.background,
      dividerTheme: DividerThemeData(color: colors.outline, thickness: 1, space: 1),
      inputDecorationTheme: _inputDecorationTheme(colors, styles),
      dialogTheme: _dialogTheme(colors, styles),
      chipTheme: _chipTheme(colors, styles),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.ml.r)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.tertiary,
        contentTextStyle: styles.bodyMedium?.copyWith(color: colors.onTertiary),
        behavior: SnackBarBehavior.floating,
        insetPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 22.0.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.ml.r)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(colors.white),
        trackColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.selected) ? colors.primary : colors.surfaceContainerHighest,
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }

  static CardThemeData _cardTheme(AppColors colors) => CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: colors.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.ml),
          side: BorderSide(color: colors.borderColor),
        ),
      );

  static ListTileThemeData _listTileTheme(AppColors colors) => ListTileThemeData(
        iconColor: colors.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.m)),
      );

  static AppBarTheme _appBarTheme(AppColors colors, AppStyles styles, Brightness brightness) => AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colors.background,
        foregroundColor: colors.cardTitle,
        iconTheme: IconThemeData(color: colors.cardTitle),
        titleTextStyle: styles.titleLarge?.copyWith(color: colors.cardTitle),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: brightness,
          statusBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
      );

  static NavigationBarThemeData _navigationBarTheme(AppColors colors, AppStyles styles) => NavigationBarThemeData(
        elevation: 0,
        backgroundColor: colors.surface,
        indicatorColor: colors.primaryHighlight,
        labelTextStyle: WidgetStatePropertyAll(styles.labelMedium),
      );

  static NavigationRailThemeData _navigationRailTheme(AppColors colors, AppStyles styles) => NavigationRailThemeData(
        backgroundColor: colors.surface,
        indicatorColor: colors.primaryHighlight,
        selectedLabelTextStyle: styles.labelMedium?.copyWith(color: colors.primary),
        unselectedLabelTextStyle: styles.labelMedium?.copyWith(color: colors.onSurfaceVariant),
      );

  static InputDecorationTheme _inputDecorationTheme(AppColors colors, AppStyles styles) {
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.ml),
      borderSide: BorderSide(color: colors.surfaceContainerHighest),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.ml),
      borderSide: BorderSide(color: colors.error),
    );
    final defaultTextStyle = styles.bodyMedium!;
    return InputDecorationTheme(
      isDense: true,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: defaultTextStyle.copyWith(color: colors.onSurface),
      hintStyle: defaultTextStyle.copyWith(color: colors.onSurfaceVariant),
      fillColor: colors.surface,
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder.copyWith(borderSide: BorderSide(color: colors.primary)),
      focusedErrorBorder: errorBorder,
      errorBorder: errorBorder,
      errorMaxLines: 3,
      prefixIconColor: colors.onSurfaceVariant,
      suffixIconColor: colors.onSurfaceVariant,
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
    );
  }

  static DialogThemeData _dialogTheme(AppColors colors, AppStyles styles) => DialogThemeData(
        elevation: 6,
        backgroundColor: colors.surface,
        surfaceTintColor: colors.surface,
        titleTextStyle: styles.titleLarge,
        contentTextStyle: styles.bodyMedium?.copyWith(color: colors.cardSubTitle),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg.r)),
      );

  static ChipThemeData _chipTheme(AppColors colors, AppStyles styles) => ChipThemeData(
        backgroundColor: colors.surface,
        selectedColor: colors.primaryHighlight,
        side: BorderSide(color: colors.borderColor),
        labelStyle: styles.labelMedium,
        showCheckmark: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.round)),
      );
}

extension ThemeExtensions on ThemeData {
  AppDimens get dimensions => _dimensions;

  AppColors get colors => brightness == Brightness.light ? _lightColors : _darkColors;

  AppStyles get textStyles => brightness == Brightness.light ? _lightStyles : _darkStyles;
}
