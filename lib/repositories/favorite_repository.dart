import '../core/errors/app_exception.dart';
import '../models/favorite_entry.dart';
import '../services/hive_service.dart';

class FavoriteRepository {
  List<FavoriteEntry> getAll() {
    try {
      final all = HiveService.favoritesBox.values.toList();
      all.sort((a, b) => b.addedAt.compareTo(a.addedAt));
      return all;
    } catch (_) {
      throw const StorageException('Could not load favorites.');
    }
  }

  bool isFavorite(String destinationId) => HiveService.favoritesBox.containsKey(destinationId);

  Future<void> add(String destinationId) async {
    try {
      await HiveService.favoritesBox.put(
        destinationId,
        FavoriteEntry(destinationId: destinationId, addedAt: DateTime.now()),
      );
    } catch (_) {
      throw const StorageException('Could not add to favorites.');
    }
  }

  Future<void> remove(String destinationId) async {
    try {
      await HiveService.favoritesBox.delete(destinationId);
    } catch (_) {
      throw const StorageException('Could not remove from favorites.');
    }
  }

  Future<void> toggle(String destinationId) async {
    if (isFavorite(destinationId)) {
      await remove(destinationId);
    } else {
      await add(destinationId);
    }
  }

  List<String> get favoriteIds => HiveService.favoritesBox.keys.cast<String>().toList();
}
