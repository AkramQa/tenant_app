import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/injectable_module.dart';
import 'package:tenant_app/injection.dart';
import 'package:tenant_app/src/app.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final dependencies = await configureInjection();

    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(dependencies.sharedPreferences),
          hiveCacheBoxProvider.overrideWithValue(dependencies.hiveCacheBox),
          appDocumentsDirectoryProvider.overrideWithValue(dependencies.documentsDirectory),
        ],
        child: const App(),
      ),
    );
  }, (error, stack) {
    // Hook for Crashlytics / Sentry in a production build.
    debugPrint('Uncaught error: $error\n$stack');
    if (kDebugMode) FlutterError.presentError(FlutterErrorDetails(exception: error, stack: stack));
  });
}
