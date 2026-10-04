part of 'app_settings_notifier.dart';

@immutable
class AppSettingsState {
  /// `null` = follow the device language.
  final LanguageEnum? language;
  final ThemeMode themeMode;

  const AppSettingsState({required this.language, required this.themeMode});

  AppSettingsState copyWith({LanguageEnum? Function()? language, ThemeMode? themeMode}) => AppSettingsState(
        language: language != null ? language() : this.language,
        themeMode: themeMode ?? this.themeMode,
      );
}
