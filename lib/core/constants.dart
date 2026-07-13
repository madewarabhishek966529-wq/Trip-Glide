/// App-wide constants: naming, durations, spacing, and Hive box names.
///
/// Keeping Hive box names here (rather than sprinkled as string literals
/// through repositories) avoids typo bugs where a box is opened under one
/// name and queried under another.
class AppConstants {
  AppConstants._();

  static const String appName = 'TripGlide';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Welcome to TripGlide';

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Spacing scale (use these instead of magic numbers in widgets)
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;
  static const double spaceXxl = 48;

  // Radii
  static const double radiusSm = 8;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusPill = 100;

  // Responsive breakpoints (logical pixels)
  static const double breakpointTablet = 600;
  static const double breakpointDesktop = 1024;

  // Hive box names
  static const String boxCategories = 'categories_box';
  static const String boxDestinations = 'destinations_box';
  static const String boxReviews = 'reviews_box';
  static const String boxBookings = 'bookings_box';
  static const String boxFavorites = 'favorites_box';
  static const String boxRecentlyViewed = 'recently_viewed_box';
  static const String boxUserProfile = 'user_profile_box';
  static const String boxSettings = 'settings_box';

  // Settings keys (used inside boxSettings)
  static const String settingsKeyThemeMode = 'theme_mode';
  static const String settingsKeyNotifications = 'notifications_enabled';
  static const String settingsKeyLanguage = 'language';

  // Business rules
  static const int maxRecentlyViewed = 15;
  static const int maxGuestsPerBooking = 12;
  static const int minGuestsPerBooking = 1;
}
