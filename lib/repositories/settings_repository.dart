import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../services/hive_service.dart';

/// Wraps the dynamic Hive "settings" box for simple key/value app
/// preferences (theme mode, notifications toggle, language).
class SettingsRepository {
  ThemeMode getThemeMode() {
    final value = HiveService.settingsBox.get(AppConstants.settingsKeyThemeMode, defaultValue: 'system') as String;
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await HiveService.settingsBox.put(AppConstants.settingsKeyThemeMode, value);
  }

  bool getNotificationsEnabled() =>
      HiveService.settingsBox.get(AppConstants.settingsKeyNotifications, defaultValue: true) as bool;

  Future<void> setNotificationsEnabled(bool enabled) async {
    await HiveService.settingsBox.put(AppConstants.settingsKeyNotifications, enabled);
  }

  String getLanguage() =>
      HiveService.settingsBox.get(AppConstants.settingsKeyLanguage, defaultValue: 'English') as String;

  Future<void> setLanguage(String language) async {
    await HiveService.settingsBox.put(AppConstants.settingsKeyLanguage, language);
  }
}
