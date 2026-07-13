import 'package:hive_flutter/hive_flutter.dart';
import '../core/constants.dart';
import '../models/category.dart';
import '../models/destination.dart';
import '../models/review.dart';
import '../models/booking.dart';
import '../models/user.dart';
import '../models/favorite_entry.dart';
import '../models/recently_viewed_entry.dart';

/// Initializes Hive, registers every [TypeAdapter], and opens every box the
/// app needs. Call [HiveService.init] once, before [runApp], from `main`.
///
/// This is the *only* place adapters get registered — if you add a new
/// Hive model, register its adapter here with a typeId that isn't already
/// used (see the comment next to each registration).
class HiveService {
  HiveService._();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    Hive.registerAdapter(CategoryAdapter()); // typeId 0
    Hive.registerAdapter(DestinationAdapter()); // typeId 1
    Hive.registerAdapter(ReviewAdapter()); // typeId 2
    Hive.registerAdapter(BookingAdapter()); // typeId 3
    Hive.registerAdapter(UserProfileAdapter()); // typeId 4
    Hive.registerAdapter(FavoriteEntryAdapter()); // typeId 5
    Hive.registerAdapter(RecentlyViewedEntryAdapter()); // typeId 6

    await Future.wait([
      Hive.openBox<Category>(AppConstants.boxCategories),
      Hive.openBox<Destination>(AppConstants.boxDestinations),
      Hive.openBox<Review>(AppConstants.boxReviews),
      Hive.openBox<Booking>(AppConstants.boxBookings),
      Hive.openBox<UserProfile>(AppConstants.boxUserProfile),
      Hive.openBox<FavoriteEntry>(AppConstants.boxFavorites),
      Hive.openBox<RecentlyViewedEntry>(AppConstants.boxRecentlyViewed),
      Hive.openBox(AppConstants.boxSettings), // dynamic box for primitive settings
    ]);

    _initialized = true;
  }

  static Box<Category> get categoriesBox => Hive.box<Category>(AppConstants.boxCategories);
  static Box<Destination> get destinationsBox => Hive.box<Destination>(AppConstants.boxDestinations);
  static Box<Review> get reviewsBox => Hive.box<Review>(AppConstants.boxReviews);
  static Box<Booking> get bookingsBox => Hive.box<Booking>(AppConstants.boxBookings);
  static Box<UserProfile> get userProfileBox => Hive.box<UserProfile>(AppConstants.boxUserProfile);
  static Box<FavoriteEntry> get favoritesBox => Hive.box<FavoriteEntry>(AppConstants.boxFavorites);
  static Box<RecentlyViewedEntry> get recentlyViewedBox =>
      Hive.box<RecentlyViewedEntry>(AppConstants.boxRecentlyViewed);
  static Box get settingsBox => Hive.box(AppConstants.boxSettings);

  /// Wipes every box. Used by Settings > "Reset app data".
  static Future<void> clearAll() async {
    await Future.wait([
      categoriesBox.clear(),
      destinationsBox.clear(),
      reviewsBox.clear(),
      bookingsBox.clear(),
      userProfileBox.clear(),
      favoritesBox.clear(),
      recentlyViewedBox.clear(),
      settingsBox.clear(),
    ]);
  }
}
