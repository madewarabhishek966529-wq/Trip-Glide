import 'booking_repository.dart';
import 'category_repository.dart';
import 'destination_repository.dart';
import 'favorite_repository.dart';
import 'review_repository.dart';
import 'settings_repository.dart';
import 'user_repository.dart';

/// Backs the "Reset app data" action in Settings. Wipes every box —
/// destinations, categories, reviews, bookings, favorites, profile, and
/// settings — so the app returns to a true first-run state. Callers should
/// re-run seeding immediately after this resolves.
class ResetService {
  final DestinationRepository destinationRepository;
  final CategoryRepository categoryRepository;
  final ReviewRepository reviewRepository;
  final BookingRepository bookingRepository;
  final FavoriteRepository favoriteRepository;
  final UserRepository userRepository;
  final SettingsRepository settingsRepository;

  ResetService({
    required this.destinationRepository,
    required this.categoryRepository,
    required this.reviewRepository,
    required this.bookingRepository,
    required this.favoriteRepository,
    required this.userRepository,
    required this.settingsRepository,
  });

  Future<void> clearAll() async {
    await destinationRepository.clearAll();
    await categoryRepository.clearAll();
    await reviewRepository.clearAll();
    await bookingRepository.clearAll();
    await favoriteRepository.clearAll();
    await userRepository.clear();
    await settingsRepository.clearAll();
  }
}
