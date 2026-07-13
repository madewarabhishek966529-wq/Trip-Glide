import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';
import '../models/booking.dart';
import '../models/category.dart';
import '../models/destination.dart';
import '../models/review.dart';
import '../models/user_profile.dart';

/// Registers every hand-written Hive adapter in one place.
/// Call `HiveRegistrar.registerAll()` once, right after `Hive.initFlutter()`,
/// before opening any boxes.
class HiveRegistrar {
  HiveRegistrar._();

  static void registerAll() {
    if (!Hive.isAdapterRegistered(HiveTypeIds.destination)) {
      Hive.registerAdapter(DestinationAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.category)) {
      Hive.registerAdapter(CategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.review)) {
      Hive.registerAdapter(ReviewAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.booking)) {
      Hive.registerAdapter(BookingAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.userProfile)) {
      Hive.registerAdapter(UserProfileAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.bookingStatus)) {
      Hive.registerAdapter(BookingStatusAdapter());
    }
  }
}
