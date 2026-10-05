import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/data/models/enum/languages_enum.dart';
import 'package:tenant_app/core/l10n/app_localizations.dart';
import 'package:tenant_app/core/presentation/providers/app_settings/app_settings_notifier.dart';
import 'package:tenant_app/core/presentation/providers/auth/auth_notifier.dart';
import 'package:tenant_app/core/presentation/routes/app_router.dart';
import 'package:tenant_app/core/theme/app_theme.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/forms/validation_messages.dart';
import 'package:tenant_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';

const double _kMaxTextScaleFactor = 1.3;

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late final GoRouter _appRouter = ref.read(appRouterProvider);

  @override
  Widget build(BuildContext context) {
    // Global auth reaction (Ulearna's MultiBlocListener on AuthBloc).
    ref.listen<AuthState>(authProvider, (previous, state) {
      if (previous is Authenticated && state is Unauthenticated) {
        refreshAppData();
        _appRouter.go(SignInScreen.routePath);
      }
    });

    final settings = ref.watch(appSettingsProvider);
    final LanguageEnum themeLanguage = settings.language ?? LanguageEnum.english;

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => context.l10n.app_name,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: settings.language?.asLocale,
          theme: AppTheme.provideThemeData(context, language: themeLanguage, brightness: Brightness.light),
          darkTheme: AppTheme.provideThemeData(context, language: themeLanguage, brightness: Brightness.dark),
          themeMode: settings.themeMode,
          routerConfig: _appRouter,
          builder: (context, widget) {
            return ReactiveFormConfig(
              validationMessages: appValidationMessages(context),
              child: MediaQuery.withClampedTextScaling(maxScaleFactor: _kMaxTextScaleFactor, child: widget!),
            );
          },
        );
      },
    );
  }

  /// Drops per-user cached state after logout.
  void refreshAppData() {
    unawaited(ref.read(serviceRequestsRepositoryProvider).clearCachedServiceRequests());
    ref.invalidate(serviceRequestsListProvider);
  }
}
