import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/data/models/enum/languages_enum.dart';
import 'package:tenant_app/core/theme/app_theme.dart';
import 'package:tenant_app/core/utils/forms/validation_messages.dart';
import 'package:tenant_app/core/l10n/app_localizations.dart';

/// Pumps [child] inside the same shell the app uses: Riverpod, screenutil,
/// theme, localization (English) and reactive-forms messages.
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget child, {ProviderContainer? container}) async {
    await pumpWidget(
      UncontrolledProviderScope(
        container: container ?? ProviderContainer(),
        child: ScreenUtilInit(
          designSize: const Size(393, 852),
          builder: (context, _) => MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.provideThemeData(context, language: LanguageEnum.english, brightness: Brightness.light),
            themeMode: ThemeMode.light,
            builder: (context, widget) => ReactiveFormConfig(
              validationMessages: appValidationMessages(context),
              child: widget!,
            ),
            home: child,
          ),
        ),
      ),
    );
    // Localizations load asynchronously; no infinite animations here.
    await pumpAndSettle();
  }
}
