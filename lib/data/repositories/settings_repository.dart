import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../../core/hive_boxes.dart';

class SettingsRepository {
  Box get _box => HiveBoxes.settings;

  ThemeMode getThemeMode() {
    try {
      final stored = _box.get(AppConstants.themeModeKey, defaultValue: 'system') as String;
      return switch (stored) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    } on HiveError {
      throw const StorageException('Could not load theme setting.');
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    try {
      await _box.put(AppConstants.themeModeKey, value);
    } on HiveError {
      throw const StorageException('Could not save theme setting.');
    }
  }

  int getSeedVersion() {
    try {
      return _box.get(AppConstants.seedVersionKey, defaultValue: 0) as int;
    } on HiveError {
      throw const StorageException('Could not read seed version.');
    }
  }

  Future<void> setSeedVersion(int version) async {
    try {
      await _box.put(AppConstants.seedVersionKey, version);
    } on HiveError {
      throw const StorageException('Could not save seed version.');
    }
  }

  /// Only clears settings themselves (theme, seed version) — NOT the whole
  /// app. Full reset lives in ResetService so it's obvious at the call site
  /// that it's destructive.
  Future<void> clearAll() async {
    try {
      await _box.clear();
    } on HiveError {
      throw const StorageException('Could not clear settings.');
    }
  }
}
