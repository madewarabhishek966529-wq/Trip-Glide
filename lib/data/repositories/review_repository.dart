import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../core/exceptions.dart';
import '../../core/hive_boxes.dart';
import '../../models/review.dart';

class ReviewRepository {
  final _uuid = const Uuid();

  Box<Review> get _box => HiveBoxes.reviews;

  List<Review> getByDestination(String destinationId) {
    try {
      final list = _box.values.where((r) => r.destinationId == destinationId).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      return list;
    } on HiveError {
      throw const StorageException('Could not load reviews.');
    }
  }

  double averageRating(String destinationId) {
    final reviews = getByDestination(destinationId);
    if (reviews.isEmpty) return 0;
    final sum = reviews.fold<double>(0, (acc, r) => acc + r.rating);
    return sum / reviews.length;
  }

  Future<Review> add(Review review) async {
    _validate(review);
    final withId = review.id.isEmpty ? review.copyWith(id: _uuid.v4()) : review;
    try {
      await _box.put(withId.id, withId);
      return withId;
    } on HiveError {
      throw const StorageException('Could not save review.');
    }
  }

  Future<void> delete(String id) async {
    if (!_box.containsKey(id)) throw NotFoundException('Review', id);
    try {
      await _box.delete(id);
    } on HiveError {
      throw const StorageException('Could not delete review.');
    }
  }

  Future<void> clearAll() async {
    try {
      await _box.clear();
    } on HiveError {
      throw const StorageException('Could not clear reviews.');
    }
  }

  void _validate(Review r) {
    if (r.userName.trim().isEmpty) throw const ValidationException('Reviewer name is required.');
    if (r.comment.trim().isEmpty) throw const ValidationException('Review comment is required.');
    if (r.rating < 0 || r.rating > 5) throw const ValidationException('Rating must be between 0 and 5.');
  }
}
