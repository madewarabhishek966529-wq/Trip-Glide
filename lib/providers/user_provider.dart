import 'package:flutter/foundation.dart';
import '../core/errors/app_exception.dart';
import '../models/user.dart';
import '../repositories/booking_repository.dart';
import '../repositories/favorite_repository.dart';
import '../repositories/user_repository.dart';

/// Owns the local user's profile plus the derived stats shown on the
/// Profile screen (trips completed, favorites count). Recomputing these
/// from the other repositories (rather than storing counters that could
/// drift) keeps the numbers always correct.
class UserProvider extends ChangeNotifier {
  final UserRepository _userRepo;
  final BookingRepository _bookingRepo;
  final FavoriteRepository _favoriteRepo;

  UserProvider({
    UserRepository? userRepo,
    BookingRepository? bookingRepo,
    FavoriteRepository? favoriteRepo,
  })  : _userRepo = userRepo ?? UserRepository(),
        _bookingRepo = bookingRepo ?? BookingRepository(),
        _favoriteRepo = favoriteRepo ?? FavoriteRepository();

  UserProfile? _profile;
  UserProfile? get profile => _profile;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void load() {
    try {
      _profile = _userRepo.getProfile();
      _errorMessage = null;
    } on AppException catch (e) {
      _errorMessage = e.message;
    }
    notifyListeners();
  }

  Future<void> updateProfile({String? name, String? email, String? avatar}) async {
    final current = _profile;
    if (current == null) return;
    try {
      final updated = current.copyWith(name: name, email: email, avatar: avatar);
      await _userRepo.updateProfile(updated);
      _profile = updated;
      _errorMessage = null;
    } on AppException catch (e) {
      _errorMessage = e.message;
    }
    notifyListeners();
  }

  int get tripsCompleted => _bookingRepo.completedTripCount;

  int get favoritesCount => _favoriteRepo.getAll().length;
}
