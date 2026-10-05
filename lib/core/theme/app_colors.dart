import 'package:flutter/material.dart';

@immutable
class AppColors extends ColorScheme {
  const AppColors({
    required super.brightness,
    required super.primary,
    required super.onPrimary,
    required super.secondary,
    required super.onSecondary,
    required super.error,
    required super.onError,
    required super.surface,
    required super.onSurface,
    required this.background,
    required this.primaryHighlight,
    required this.cardTitle,
    required this.cardSubTitle,
    required this.borderColor,
    required this.white,
    required this.black,
    required this.success,
    required this.warning,
    required this.info,
    required this.urgent,
    required this.statusPending,
    required this.statusAssigned,
    required this.statusInProgress,
    required this.statusCompleted,
    required this.serviceMaintenance,
    required this.servicePlumbing,
    required this.serviceElectrical,
    required this.serviceAcMaintenance,
    required this.serviceCleaning,
    required this.shimmerBase,
    required this.shimmerHighlight,
    super.primaryContainer,
    super.onPrimaryContainer,
    super.tertiary,
    super.onTertiary,
    super.errorContainer,
    super.onErrorContainer,
    super.onSurfaceVariant,
    super.surfaceContainerHighest,
    super.outline,
    super.outlineVariant,
    super.shadow,
    super.scrim,
    super.inverseSurface,
    super.onInverseSurface,
    super.surfaceTint,
  });

  /// Scaffold background (slightly off the card [surface]).
  @override
  final Color background;
  final Color primaryHighlight;
  final Color cardTitle;
  final Color cardSubTitle;
  final Color borderColor;
  final Color white;
  final Color black;

  // Semantic
  final Color success;
  final Color warning;
  final Color info;
  final Color urgent;

  // Request status
  final Color statusPending;
  final Color statusAssigned;
  final Color statusInProgress;
  final Color statusCompleted;

  // Service types
  final Color serviceMaintenance;
  final Color servicePlumbing;
  final Color serviceElectrical;
  final Color serviceAcMaintenance;
  final Color serviceCleaning;

  // Loading placeholders
  final Color shimmerBase;
  final Color shimmerHighlight;

  static AppColors getAppColors({required Brightness brightness}) {
    return brightness == Brightness.light ? _lightColorScheme() : _darkColorScheme();
  }

  static AppColors _lightColorScheme() => const AppColors(
        brightness: Brightness.light,
        primary: Color(0xFF2197FF),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFD1E4FF),
        onPrimaryContainer: Color(0xFF0A0A0B),
        secondary: Color(0xFF92A5B5),
        onSecondary: Color(0xFFFFFFFF),
        tertiary: Color(0xFF2B2F38),
        onTertiary: Color(0xFFFFFFFF),
        error: Color(0xFFDA3E33),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF2B2F38),
        onSurfaceVariant: Color(0xFF667085),
        surfaceContainerHighest: Color(0xFFDFE2EB),
        outline: Color(0xFFE8E8E9),
        outlineVariant: Color(0xFFC3C7CF),
        inverseSurface: Color(0xFF2F3033),
        onInverseSurface: Color(0xFFF1F0F4),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
        surfaceTint: Color(0x00000000),
        //
        background: Color(0xFFF5F7FA),
        primaryHighlight: Color(0xFFE0F4FF),
        cardTitle: Color(0xFF0B0B10),
        cardSubTitle: Color(0xFF65656E),
        borderColor: Color(0xFFE1E8E8),
        white: Color(0xFFFFFFFF),
        black: Color(0xFF000000),
        //
        success: Color(0xFF14A35B),
        warning: Color(0xFFE0912D),
        info: Color(0xFF3C9FCF),
        urgent: Color(0xFFE80028),
        //
        statusPending: Color(0xFFE0912D),
        statusAssigned: Color(0xFF625BF6),
        statusInProgress: Color(0xFF2197FF),
        statusCompleted: Color(0xFF14A35B),
        //
        serviceMaintenance: Color(0xFF625BF6),
        servicePlumbing: Color(0xFF2197FF),
        serviceElectrical: Color(0xFFE0912D),
        serviceAcMaintenance: Color(0xFF15B097),
        serviceCleaning: Color(0xFFE4626F),
        //
        shimmerBase: Color(0xFFE3E3E3),
        shimmerHighlight: Color(0xFFFAFAFA),
      );

  static AppColors _darkColorScheme() => const AppColors(
        brightness: Brightness.dark,
        primary: Color(0xFF4DA9FF),
        onPrimary: Color(0xFF0A0A0B),
        primaryContainer: Color(0xFF0B3A66),
        onPrimaryContainer: Color(0xFFD1E4FF),
        secondary: Color(0xFFAAB9C5),
        onSecondary: Color(0xFF0A0A0B),
        tertiary: Color(0xFFF0F1F3),
        onTertiary: Color(0xFF131417),
        error: Color(0xFFFF6B60),
        onError: Color(0xFF0A0A0B),
        errorContainer: Color(0xFF93000A),
        onErrorContainer: Color(0xFFFFDAD6),
        surface: Color(0xFF1C1E24),
        onSurface: Color(0xFFF0F1F3),
        onSurfaceVariant: Color(0xFFB9BDC7),
        surfaceContainerHighest: Color(0xFF383E49),
        outline: Color(0xFF2D3139),
        outlineVariant: Color(0xFF48505E),
        inverseSurface: Color(0xFFF0F1F3),
        onInverseSurface: Color(0xFF131417),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
        surfaceTint: Color(0x00000000),
        //
        background: Color(0xFF131417),
        primaryHighlight: Color(0xFF1C4A5F),
        cardTitle: Color(0xFFF0F1F3),
        cardSubTitle: Color(0xFFB9BDC7),
        borderColor: Color(0xFF2D3139),
        white: Color(0xFFFFFFFF),
        black: Color(0xFF000000),
        //
        success: Color(0xFF3FCF8E),
        warning: Color(0xFFF5B158),
        info: Color(0xFF6CC3EE),
        urgent: Color(0xFFFF4D6A),
        //
        statusPending: Color(0xFFF5B158),
        statusAssigned: Color(0xFF9691F9),
        statusInProgress: Color(0xFF4DA9FF),
        statusCompleted: Color(0xFF3FCF8E),
        //
        serviceMaintenance: Color(0xFF9691F9),
        servicePlumbing: Color(0xFF4DA9FF),
        serviceElectrical: Color(0xFFF5B158),
        serviceAcMaintenance: Color(0xFF3FD1BA),
        serviceCleaning: Color(0xFFFF8A95),
        //
        shimmerBase: Color(0xFF2D3139),
        shimmerHighlight: Color(0xFF383E49),
      );
}
