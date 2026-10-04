import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/exception.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';
import 'package:tenant_app/injectable_module.dart';

abstract class AuthenticationLocalSource {
  /// save user access token (Keychain / Keystore)
  Future<void> saveAccessToken(String accessToken);

  /// read user access token
  Future<String?> getAccessToken();

  /// delete user access token
  Future<void> deleteAccessToken();

  /// persist the signed in user profile
  Future<bool> signInUser(TenantInfoModel tenantInfo);

  /// read the signed in user profile
  TenantInfoModel? getSignedInUserInfo();

  /// remove the signed in user profile
  Future<bool> deleteSignedInUserInfo();
}

/// `@LazySingleton(as: AuthenticationLocalSource)`
final authenticationLocalSourceProvider = Provider<AuthenticationLocalSource>(
  (ref) => AuthenticationLocalSourceImpl(
    ref.watch(secureStorageProvider),
    ref.watch(sharedPreferencesProvider),
  ),
);

class AuthenticationLocalSourceImpl implements AuthenticationLocalSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  AuthenticationLocalSourceImpl(this.secureStorage, this.sharedPreferences);

  @override
  Future<void> saveAccessToken(String accessToken) =>
      secureStorage.write(key: SecureStorageKeys.accessToken, value: accessToken);

  @override
  Future<String?> getAccessToken() => secureStorage.read(key: SecureStorageKeys.accessToken);

  @override
  Future<void> deleteAccessToken() => secureStorage.delete(key: SecureStorageKeys.accessToken);

  @override
  Future<bool> signInUser(TenantInfoModel tenantInfo) =>
      sharedPreferences.setString(SharedPreferencesKeys.user, json.encode(tenantInfo.toJson()));

  @override
  TenantInfoModel? getSignedInUserInfo() {
    final String? userAsString = sharedPreferences.getString(SharedPreferencesKeys.user);
    if (userAsString == null) return null;
    try {
      return TenantInfoModel.fromJson(json.decode(userAsString) as Map<String, dynamic>);
    } catch (e) {
      throw CacheException('Corrupted user cache: $e');
    }
  }

  @override
  Future<bool> deleteSignedInUserInfo() => sharedPreferences.remove(SharedPreferencesKeys.user);
}
