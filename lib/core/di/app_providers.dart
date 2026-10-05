import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/network/mock/mock_backend_interceptor.dart';
import 'package:tenant_app/core/data/utils/network/network_info.dart';
import 'package:tenant_app/features/auth/data/datasources/remote/mock/auth_mock_server.dart';
import 'package:tenant_app/features/service_requests/data/datasources/remote/mock/service_requests_mock_server.dart';
import 'package:uuid/uuid.dart';

/// App-wide providers for platform and third-party services.
///
/// Providers that throw are created asynchronously in `initAppDependencies()`
/// and overridden in `main()`.

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider is created in initAppDependencies()'),
);

final hiveCacheBoxProvider = Provider<Box<dynamic>>(
  (ref) => throw UnimplementedError('hiveCacheBoxProvider is created in initAppDependencies()'),
);

final appDocumentsDirectoryProvider = Provider<Directory>(
  (ref) => throw UnimplementedError('appDocumentsDirectoryProvider is created in initAppDependencies()'),
);

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final connectionCheckerProvider = Provider<InternetConnection>((ref) => InternetConnection());

final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

final loggerProvider = Provider<Logger>((ref) => Logger(printer: PrettyPrinter(methodCount: 0)));

final uuidProvider = Provider<Uuid>((ref) => const Uuid());

final dioOptionsProvider = Provider<BaseOptions>(
  (ref) => BaseOptions(
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    connectTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    validateStatus: (statusCode) => statusCode != null && statusCode >= 200 && statusCode < 300,
  ),
);

final dioProvider = Provider<Dio>((ref) {
  final SharedPreferences sharedPreferences = ref.watch(sharedPreferencesProvider);
  final dio = Dio(ref.watch(dioOptionsProvider));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) {
        request.headers['Accept-Language'] =
            (sharedPreferences.getString(SharedPreferencesKeys.lang) ?? 'en').toUpperCase();
        return handler.next(request);
      },
    ),
  );
  // No backend yet: answered locally. Remove to hit Configuration.getBaseUrl.
  dio.interceptors.add(
    MockBackendInterceptor(ref.watch(networkInfoProvider), [
      AuthMockServer(),
      ServiceRequestsMockServer(sharedPreferences, ref.watch(uuidProvider)),
    ]),
  );
  return dio;
});
