import 'package:hive/hive.dart';

import '../../core/exceptions.dart';
import '../../core/hive_boxes.dart';

/// Favorites don't need their own model — a destination is either favorited
/// or it isn't, so we key a Box<bool> by destinationId and only ever store
/// `true` (absence of a key means "not favorited").
class FavoriteRepository {
  Box<bool> get _box => HiveBoxes.favorites;

  bool isFavorite(String destinationId) {
    try {
      return _box.get(destinationId, defaultValue: false) ?? false;
    } on HiveError {
      throw const StorageException('Could not read favorites.');
    }
  }

  List<String> getAllIds() {
    try {
      return _box.keys.cast<String>().toList();
    } on HiveError {
      throw const StorageException('Could not load favorites.');
    }
  }

  Future<bool> toggle(String destinationId) async {
    try {
      final isFav = isFavorite(destinationId);
      if (isFav) {
        await _box.delete(destinationId);
      } else {
        await _box.put(destinationId, true);
      }
      return !isFav;
    } on HiveError {
      throw const StorageException('Could not update favorites.');
    }
  }

  Future<void> clearAll() async {
    try {
      await _box.clear();
    } on HiveError {
      throw const StorageException('Could not clear favorites.');
    }
  }
}
