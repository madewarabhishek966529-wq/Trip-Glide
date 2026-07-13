import '../core/constants.dart';
import '../data/categories_data.dart';
import '../data/destinations_data.dart';
import '../data/reviews_data.dart';
import '../models/user.dart';
import 'hive_service.dart';

/// Populates Hive with starter content the very first time the app runs.
///
/// This is intentionally idempotent and cheap to call on every app start:
/// each box is only written to if it's currently empty, so re-installing
/// or hot-restarting never duplicates data, and anything the user adds or
/// deletes afterward is respected.
class SeedService {
  SeedService._();

  static Future<void> seedIfNeeded() async {
    if (HiveService.categoriesBox.isEmpty) {
      final map = {for (final c in seedCategories) c.id: c};
      await HiveService.categoriesBox.putAll(map);
    }

    if (HiveService.destinationsBox.isEmpty) {
      final map = {for (final d in seedDestinations) d.id: d};
      await HiveService.destinationsBox.putAll(map);
    }

    if (HiveService.reviewsBox.isEmpty) {
      final reviews = buildSeedReviews();
      final map = {for (final r in reviews) r.id: r};
      await HiveService.reviewsBox.putAll(map);
    }

    if (HiveService.userProfileBox.isEmpty) {
      await HiveService.userProfileBox.put(
        'current_user',
        UserProfile(
          name: 'Vanessa Cole',
          email: 'vanessa.cole@example.com',
          avatar: 'https://picsum.photos/seed/vanessa-profile/300/300',
          tripsCompleted: 0,
          joinedDate: DateTime.now(),
        ),
      );
    }
  }
}
