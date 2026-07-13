import 'package:flutter/foundation.dart';
import '../core/errors/app_exception.dart';
import '../models/destination.dart';
import '../repositories/destination_repository.dart';
import '../repositories/favorite_repository.dart';

/// Owns favorite state. Holds a `Set<String>` of favorited destination ids
/// in memory (mirrored from Hive) so `isFavorite` checks in list items are
/// O(1) and don't hit the box on every rebuild.
class FavoriteProvider extends ChangeNotifier {
  final FavoriteRepository _favoriteRepo;
  final DestinationRepository _destinationRepo;

  FavoriteProvider({FavoriteRepository? favoriteRepo, DestinationRepository? destinationRepo})
      : _favoriteRepo = favoriteRepo ?? FavoriteRepository(),
        _destinationRepo = destinationRepo ?? DestinationRepository();

  Set<String> _favoriteIds = {};
  Set<String> get favoriteIds => _favoriteIds;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void load() {
    try {
      _favoriteIds = _favoriteRepo.favoriteIds.toSet();
      _errorMessage = null;
    } on AppException catch (e) {
      _errorMessage = e.message;
    }
    notifyListeners();
  }

  bool isFavorite(String destinationId) => _favoriteIds.contains(destinationId);

  Future<void> toggle(String destinationId) async {
    // Optimistic update so the heart icon responds instantly.
    final wasFavorite = _favoriteIds.contains(destinationId);
    if (wasFavorite) {
      _favoriteIds.remove(destinationId);
    } else {
      _favoriteIds.add(destinationId);
    }
    notifyListeners();

    try {
      await _favoriteRepo.toggle(destinationId);
    } on AppException catch (e) {
      // Roll back on failure.
      if (wasFavorite) {
        _favoriteIds.add(destinationId);
      } else {
        _favoriteIds.remove(destinationId);
      }
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  List<Destination> get favoriteDestinations {
    return _favoriteIds
        .map((id) => _destinationRepo.tryGetById(id))
        .whereType<Destination>()
        .toList();
  }

  List<Destination> search(String query) {
    if (query.trim().isEmpty) return favoriteDestinations;
    final q = query.trim().toLowerCase();
    return favoriteDestinations
        .where((d) => d.city.toLowerCase().contains(q) || d.country.toLowerCase().contains(q))
        .toList();
  }

  int get count => _favoriteIds.length;
}
