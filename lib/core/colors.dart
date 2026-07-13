import 'package:flutter/material.dart';

/// Centralized color palette for TripGlide.
///
/// The design reference uses a minimalist black/white system with a warm
/// terracotta accent (echoing the desert/mountain imagery) for ratings,
/// prices, and highlighted states. Keeping every color here means the rest
/// of the app never hardcodes a `Color(0x...)` value.
class AppColors {
  AppColors._();

  // Brand
  static const Color terracotta = Color(0xFFE07856);
  static const Color terracottaLight = Color(0xFFF2A98A);

  // Light theme
  static const Color lightBackground = Color(0xFFF7F6F3);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFF0EFEC);
  static const Color lightTextPrimary = Color(0xFF1C1C1E);
  static const Color lightTextSecondary = Color(0xFF8E8E93);
  static const Color lightBorder = Color(0xFFE5E4E0);
  static const Color lightPill = Color(0xFF1C1C1E);
  static const Color lightPillText = Color(0xFFFFFFFF);

  // Dark theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceAlt = Color(0xFF262626);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFA0A0A3);
  static const Color darkBorder = Color(0xFF2F2F2F);
  static const Color darkPill = Color(0xFFF5F5F5);
  static const Color darkPillText = Color(0xFF1C1C1E);

  // Semantic
  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFFB800);
  static const Color rating = Color(0xFFFFB800);

  // Glassmorphism overlays
  static const Color glassLight = Color(0x99FFFFFF);
  static const Color glassDark = Color(0x66000000);

  /// Gradient stops used behind hero images / featured cards to keep
  /// overlaid text legible regardless of the underlying photo.
  static const List<Color> imageScrim = [
    Color(0x00000000),
    Color(0x99000000),
  ];
}
