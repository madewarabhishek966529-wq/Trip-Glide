import 'package:flutter/foundation.dart';
import '../core/errors/app_exception.dart';
import '../models/destination.dart';
import '../repositories/destination_repository.dart';
import '../repositories/recently_viewed_repository.dart';
import '../repositories/review_repository.dart';

enum LoadStatus { initial, loading, loaded, error }

/// Owns the destination catalog: category filtering, curated sections
/// (popular / recommended / top rated / recently viewed), and single
/// destination lookups. Screens read from here rather than touching
/// [DestinationRepository] directly, so there is exactly one place that
/// decides how "recommended" or "top rated" are computed.
class DestinationProvider extends ChangeNotifier {
  final DestinationRepository _destinationRepo;
  final RecentlyViewedRepository _recentlyViewedRepo;
  final ReviewRepository _reviewRepo;

  DestinationProvider({
    DestinationRepository? destinationRepo,
    RecentlyViewedRepository? recentlyViewedRepo,
    ReviewRepository? reviewRepo,
  })  : _destinationRepo = destinationRepo ?? DestinationRepository(),
        _recentlyViewedRepo = recentlyViewedRepo ?? RecentlyViewedRepository(),
        _reviewRepo = reviewRepo ?? ReviewRepository();

  LoadStatus _status = LoadStatus.initial;
  LoadStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Destination> _all = [];
  List<Destination> get all => _all;

  String _selectedCategoryId = '';
  String get selectedCategoryId => _selectedCategoryId;

  /// Loads (or reloads) the full catalog from Hive. Call once after seeding
  /// on app start; call again after any write that should be reflected
  /// everywhere (e.g. after an admin edit, if one is ever added).
  void load() {
    _status = LoadStatus.loading;
    notifyListeners();
    try {
      _all = _destinationRepo.getAll();
      _status = LoadStatus.loaded;
      _errorMessage = null;
    } on AppException catch (e) {
      _status = LoadStatus.error;
      _errorMessage = e.message;
    } catch (_) {
      _status = LoadStatus.error;
      _errorMessage = 'Something went wrong loading destinations.';
    }
    notifyListeners();
  }

  void selectCategory(String categoryId) {
    _selectedCategoryId = _selectedCategoryId == categoryId ? '' : categoryId;
    notifyListeners();
  }

  List<Destination> get filteredByCategory {
    if (_selectedCategoryId.isEmpty) return _all;
    return _all.where((d) => d.categoryId == _selectedCategoryId).toList();
  }

  Destination? byId(String id) {
    try {
      return _destinationRepo.getById(id);
    } on AppException {
      return null;
    }
  }

  List<Destination> get popular => _destinationRepo.popular(limit: 10);

  List<Destination> get topRated => _destinationRepo.topRated(limit: 10);

  List<Destination> recommendedExcluding(List<String> excludeIds) =>
      _destinationRepo.recommended(excludeIds: excludeIds, limit: 10);

  List<Destination> get recentlyViewed {
    final entries = _recentlyViewedRepo.getAll();
    return entries
        .map((e) => byId(e.destinationId))
        .whereType<Destination>()
        .toList();
  }

  Future<void> recordView(String destinationId) async {
    await _recentlyViewedRepo.recordView(destinationId);
    notifyListeners();
  }

  double averageRating(String destinationId) => _reviewRepo.averageRating(destinationId);

  List<Destination> search(String query) => _destinationRepo.search(query);
}
