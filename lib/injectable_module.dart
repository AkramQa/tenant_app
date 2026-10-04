import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Third-party / platform bindings — the Riverpod counterpart of Ulearna's
/// `@module abstract class InjectableModule`.
///
/// Providers that throw are `@preResolve` dependencies: they are created
/// asynchronously in `configureInjection()` and overridden in `main()`.

/// `@preResolve @lazySingleton`
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider is pre-resolved in configureInjection()'),
);

/// `@preResolve @lazySingleton`
final hiveCacheBoxProvider = Provider<Box<dynamic>>(
  (ref) => throw UnimplementedError('hiveCacheBoxProvider is pre-resolved in configureInjection()'),
);

/// `@preResolve @lazySingleton`
final appDocumentsDirectoryProvider = Provider<Directory>(
  (ref) => throw UnimplementedError('appDocumentsDirectoryProvider is pre-resolved in configureInjection()'),
);

/// `@lazySingleton`
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)),
);

/// `@lazySingleton`
final connectionCheckerProvider = Provider<InternetConnection>((ref) => InternetConnection());

/// `@lazySingleton`
final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

/// `@lazySingleton`
final loggerProvider = Provider<Logger>((ref) => Logger(printer: PrettyPrinter(methodCount: 0)));

/// `@lazySingleton`
final uuidProvider = Provider<Uuid>((ref) => const Uuid());
