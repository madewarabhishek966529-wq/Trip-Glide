import 'package:flutter/material.dart';
import 'colors.dart';
import 'constants.dart';

/// Material 3 theme definitions for light and dark mode.
///
/// Both themes share the same shape language (rounded corners, pill
/// buttons) and typographic scale; only the color roles change.
class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Roboto';

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.terracotta,
      brightness: Brightness.light,
      primary: AppColors.lightPill,
      onPrimary: AppColors.lightPillText,
      secondary: AppColors.terracotta,
      surface: AppColors.lightSurface,
      error: AppColors.error,
    );

    return _base(colorScheme).copyWith(
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: AppColors.lightSurface,
      dividerColor: AppColors.lightBorder,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
      textTheme: _textTheme(AppColors.lightTextPrimary, AppColors.lightTextSecondary),
      iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _pillButtonStyle(
          background: AppColors.lightPill,
          foreground: AppColors.lightPillText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _outlinedPillStyle(
          foreground: AppColors.lightTextPrimary,
          border: AppColors.lightBorder,
        ),
      ),
      inputDecorationTheme: _inputTheme(
        fill: AppColors.lightSurfaceAlt,
        hint: AppColors.lightTextSecondary,
        border: Colors.transparent,
      ),
      chipTheme: _chipTheme(
        background: AppColors.lightSurfaceAlt,
        selected: AppColors.lightPill,
        label: AppColors.lightTextPrimary,
        selectedLabel: AppColors.lightPillText,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.lightTextPrimary,
        unselectedItemColor: AppColors.lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.terracotta,
      brightness: Brightness.dark,
      primary: AppColors.darkPill,
      onPrimary: AppColors.darkPillText,
      secondary: AppColors.terracottaLight,
      surface: AppColors.darkSurface,
      error: AppColors.error,
    );

    return _base(colorScheme).copyWith(
      scaffoldBackgroundColor: AppColors.darkBackground,
      cardColor: AppColors.darkSurface,
      dividerColor: AppColors.darkBorder,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
      textTheme: _textTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary),
      iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _pillButtonStyle(
          background: AppColors.darkPill,
          foreground: AppColors.darkPillText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _outlinedPillStyle(
          foreground: AppColors.darkTextPrimary,
          border: AppColors.darkBorder,
        ),
      ),
      inputDecorationTheme: _inputTheme(
        fill: AppColors.darkSurfaceAlt,
        hint: AppColors.darkTextSecondary,
        border: Colors.transparent,
      ),
      chipTheme: _chipTheme(
        background: AppColors.darkSurfaceAlt,
        selected: AppColors.darkPill,
        label: AppColors.darkTextPrimary,
        selectedLabel: AppColors.darkPillText,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.darkTextPrimary,
        unselectedItemColor: AppColors.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  static ThemeData _base(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      fontFamily: _fontFamily,
      splashFactory: InkRipple.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static TextTheme _textTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: primary, height: 1.2),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: primary, height: 1.2),
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: primary, height: 1.25),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: primary, height: 1.3),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primary, height: 1.3),
      titleLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: primary),
      titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: primary),
      titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: primary),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: primary, height: 1.4),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: secondary, height: 1.4),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: secondary, height: 1.3),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primary),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: secondary),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: secondary),
    );
  }

  static ButtonStyle _pillButtonStyle({required Color background, required Color foreground}) {
    return ElevatedButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg, vertical: AppConstants.spaceMd),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusPill)),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }

  static ButtonStyle _outlinedPillStyle({required Color foreground, required Color border}) {
    return OutlinedButton.styleFrom(
      foregroundColor: foreground,
      side: BorderSide(color: border),
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg, vertical: AppConstants.spaceMd),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusPill)),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }

  static InputDecorationTheme _inputTheme({required Color fill, required Color hint, required Color border}) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      hintStyle: TextStyle(color: hint, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: AppConstants.spaceMd),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        borderSide: const BorderSide(color: AppColors.terracotta, width: 1.5),
      ),
    );
  }

  static ChipThemeData _chipTheme({
    required Color background,
    required Color selected,
    required Color label,
    required Color selectedLabel,
  }) {
    return ChipThemeData(
      backgroundColor: background,
      selectedColor: selected,
      labelStyle: TextStyle(color: label, fontWeight: FontWeight.w600, fontSize: 13),
      secondaryLabelStyle: TextStyle(color: selectedLabel, fontWeight: FontWeight.w600, fontSize: 13),
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: AppConstants.spaceSm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusPill)),
      side: BorderSide.none,
    );
  }
}
