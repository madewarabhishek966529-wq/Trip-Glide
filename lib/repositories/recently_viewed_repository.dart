import '../core/constants.dart';
import '../models/recently_viewed_entry.dart';
import '../services/hive_service.dart';

class RecentlyViewedRepository {
  List<RecentlyViewedEntry> getAll() {
    final all = HiveService.recentlyViewedBox.values.toList();
    all.sort((a, b) => b.viewedAt.compareTo(a.viewedAt));
    return all;
  }

  /// Records a view, moving the destination to the front and trimming the
  /// list to [AppConstants.maxRecentlyViewed].
  Future<void> recordView(String destinationId) async {
    await HiveService.recentlyViewedBox.put(
      destinationId,
      RecentlyViewedEntry(destinationId: destinationId, viewedAt: DateTime.now()),
    );

    final all = getAll();
    if (all.length > AppConstants.maxRecentlyViewed) {
      final toRemove = all.skip(AppConstants.maxRecentlyViewed);
      for (final entry in toRemove) {
        await HiveService.recentlyViewedBox.delete(entry.destinationId);
      }
    }
  }

  Future<void> clear() async => HiveService.recentlyViewedBox.clear();
}
