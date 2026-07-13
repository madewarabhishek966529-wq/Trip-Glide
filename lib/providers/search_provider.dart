import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/destination.dart';
import '../repositories/destination_repository.dart';

/// Owns the Search screen's query + filter state and debounces query
/// changes so filtering doesn't run on every single keystroke.
class SearchProvider extends ChangeNotifier {
  final DestinationRepository _destinationRepo;

  SearchProvider({DestinationRepository? destinationRepo}) : _destinationRepo = destinationRepo ?? DestinationRepository();

  Timer? _debounce;

  String _query = '';
  String get query => _query;

  String? _categoryId;
  String? get categoryId => _categoryId;

  String? _country;
  String? get country => _country;

  double? _minRating;
  double? get minRating => _minRating;

  List<Destination> _results = [];
  List<Destination> get results => _results;

  bool _hasSearched = false;
  bool get hasSearched => _hasSearched;

  void updateQuery(String value) {
    _query = value;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), _runSearch);
    notifyListeners();
  }

  void setCategory(String? categoryId) {
    _categoryId = categoryId;
    _runSearch();
  }

  void setCountry(String? country) {
    _country = country;
    _runSearch();
  }

  void setMinRating(double? rating) {
    _minRating = rating;
    _runSearch();
  }

  void clearFilters() {
    _categoryId = null;
    _country = null;
    _minRating = null;
    _runSearch();
  }

  void _runSearch() {
    _hasSearched = _query.trim().isNotEmpty || _categoryId != null || _country != null || _minRating != null;
    _results = _destinationRepo.filtered(
      query: _query,
      categoryId: _categoryId,
      country: _country,
      minRating: _minRating,
    );
    notifyListeners();
  }

  List<String> get availableCountries => _destinationRepo.allCountries();

  bool get hasActiveFilters => _categoryId != null || _country != null || _minRating != null;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
