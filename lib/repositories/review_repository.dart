import '../core/errors/app_exception.dart';
import '../models/review.dart';
import '../services/hive_service.dart';

class ReviewRepository {
  List<Review> getForDestination(String destinationId) {
    try {
      final all = HiveService.reviewsBox.values.where((r) => r.destinationId == destinationId).toList();
      all.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return all;
    } catch (_) {
      throw const StorageException('Could not load reviews.');
    }
  }

  Future<void> add(Review review) async {
    try {
      await HiveService.reviewsBox.put(review.id, review);
    } catch (_) {
      throw const StorageException('Could not submit review.');
    }
  }

  Future<void> delete(String id) async {
    try {
      await HiveService.reviewsBox.delete(id);
    } catch (_) {
      throw const StorageException('Could not delete review.');
    }
  }

  double averageRating(String destinationId) {
    final reviews = getForDestination(destinationId);
    if (reviews.isEmpty) return 0;
    final sum = reviews.fold<double>(0, (acc, r) => acc + r.rating);
    return sum / reviews.length;
  }
}
