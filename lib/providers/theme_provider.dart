import 'package:flutter/material.dart';
import '../repositories/settings_repository.dart';

class ThemeProvider extends ChangeNotifier {
  final SettingsRepository _settingsRepo;

  ThemeProvider({SettingsRepository? settingsRepo}) : _settingsRepo = settingsRepo ?? SettingsRepository();

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void load() {
    _themeMode = _settingsRepo.getThemeMode();
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _settingsRepo.setThemeMode(mode);
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isSystemMode => _themeMode == ThemeMode.system;
}
