import '../core/errors/app_exception.dart';
import '../models/destination.dart';
import '../services/hive_service.dart';

/// Full CRUD access to the destination catalog, plus the query helpers the
/// Home and Search screens need (category filter, text search, top rated,
/// recommended). Everything reads straight from the in-memory Hive box, so
/// these calls are synchronous and cheap.
class DestinationRepository {
  List<Destination> getAll() {
    try {
      return HiveService.destinationsBox.values.toList();
    } catch (_) {
      throw const StorageException('Could not load destinations.');
    }
  }

  Destination getById(String id) {
    final destination = HiveService.destinationsBox.get(id);
    if (destination == null) {
      throw const NotFoundException('This destination is no longer available.');
    }
    return destination;
  }

  Destination? tryGetById(String id) => HiveService.destinationsBox.get(id);

  Future<void> upsert(Destination destination) async {
    try {
      await HiveService.destinationsBox.put(destination.id, destination);
    } catch (_) {
      throw const StorageException('Could not save destination.');
    }
  }

  Future<void> delete(String id) async {
    try {
      await HiveService.destinationsBox.delete(id);
    } catch (_) {
      throw const StorageException('Could not delete destination.');
    }
  }

  List<Destination> byCategory(String categoryId) =>
      getAll().where((d) => d.categoryId == categoryId).toList();

  List<Destination> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.trim().toLowerCase();
    return getAll().where((d) {
      return d.city.toLowerCase().contains(q) ||
          d.country.toLowerCase().contains(q) ||
          d.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  List<Destination> filtered({
    String? categoryId,
    String? country,
    double? minRating,
    String? query,
  }) {
    var results = getAll();
    if (query != null && query.trim().isNotEmpty) {
      final q = query.trim().toLowerCase();
      results = results
          .where((d) =>
              d.city.toLowerCase().contains(q) ||
              d.country.toLowerCase().contains(q) ||
              d.tags.any((t) => t.toLowerCase().contains(q)))
          .toList();
    }
    if (categoryId != null && categoryId.isNotEmpty) {
      results = results.where((d) => d.categoryId == categoryId).toList();
    }
    if (country != null && country.isNotEmpty) {
      results = results.where((d) => d.country == country).toList();
    }
    if (minRating != null) {
      results = results.where((d) => d.rating >= minRating).toList();
    }
    return results;
  }

  List<Destination> topRated({int limit = 10}) {
    final all = getAll()..sort((a, b) => b.rating.compareTo(a.rating));
    return all.take(limit).toList();
  }

  List<Destination> popular({int limit = 10}) {
    final all = getAll()..sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    return all.take(limit).toList();
  }

  /// A lightweight "recommended for you" heuristic: highest rated
  /// destinations that aren't already in [excludeIds] (e.g. already
  /// favorited or recently viewed), so the section feels distinct from
  /// "Top rated".
  List<Destination> recommended({List<String> excludeIds = const [], int limit = 10}) {
    final all = getAll().where((d) => !excludeIds.contains(d.id)).toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return all.take(limit).toList();
  }

  List<String> allCountries() => getAll().map((d) => d.country).toSet().toList()..sort();
}
