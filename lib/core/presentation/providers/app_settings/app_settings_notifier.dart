import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_app/core/data/models/enum/languages_enum.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/di/app_providers.dart';

part 'app_settings_state.dart';

/// Persisted language + theme preferences.
final appSettingsProvider = NotifierProvider<AppSettingsNotifier, AppSettingsState>(AppSettingsNotifier.new);

class AppSettingsNotifier extends Notifier<AppSettingsState> {
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppSettingsState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return AppSettingsState(
      language: LanguageEnum.fromCode(prefs.getString(SharedPreferencesKeys.lang)),
      themeMode: ThemeMode.values.asNameMap()[prefs.getString(SharedPreferencesKeys.themeMode)] ?? ThemeMode.system,
    );
  }

  /// `null` follows the device language.
  Future<void> changeLanguage(LanguageEnum? language) async {
    state = state.copyWith(language: () => language);
    if (language == null) {
      await _prefs.remove(SharedPreferencesKeys.lang);
    } else {
      await _prefs.setString(SharedPreferencesKeys.lang, language.code);
    }
  }

  Future<void> changeThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await _prefs.setString(SharedPreferencesKeys.themeMode, themeMode.name);
  }
}
