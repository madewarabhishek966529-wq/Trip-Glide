import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';
import '../models/booking.dart';
import '../models/category.dart';
import '../models/destination.dart';
import '../models/review.dart';
import '../models/user_profile.dart';

/// Typed getters for every open box. Boxes themselves are opened once in
/// `main.dart` during startup (stage 3); repositories just read from here.
class HiveBoxes {
  HiveBoxes._();

  static Box<Destination> get destinations => Hive.box<Destination>(AppConstants.boxDestinations);
  static Box<Category> get categories => Hive.box<Category>(AppConstants.boxCategories);
  static Box<Review> get reviews => Hive.box<Review>(AppConstants.boxReviews);
  static Box<Booking> get bookings => Hive.box<Booking>(AppConstants.boxBookings);
  static Box<UserProfile> get userProfile => Hive.box<UserProfile>(AppConstants.boxUser);

  /// Favorites are just a set of destination ids -> stored as Box<bool>
  /// keyed by destinationId, avoiding a whole model+adapter for one flag.
  static Box<bool> get favorites => Hive.box<bool>(AppConstants.boxFavorites);

  /// Scalar app settings (theme mode string, seed version int) — kept in
  /// Hive rather than shared_preferences so there's a single storage
  /// mechanism and a single clearAll() sweep for the Settings reset option.
  static Box get settings => Hive.box(AppConstants.boxSettings);

  static const List<String> allBoxNames = [
    AppConstants.boxDestinations,
    AppConstants.boxCategories,
    AppConstants.boxReviews,
    AppConstants.boxBookings,
    AppConstants.boxUser,
    AppConstants.boxFavorites,
    AppConstants.boxSettings,
  ];
}
