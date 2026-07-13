import '../core/errors/app_exception.dart';
import '../models/user.dart';
import '../services/hive_service.dart';

/// The app has exactly one local user profile, stored under a fixed key.
class UserRepository {
  static const _key = 'current_user';

  UserProfile getProfile() {
    final profile = HiveService.userProfileBox.get(_key);
    if (profile == null) {
      throw const NotFoundException('No profile found.');
    }
    return profile;
  }

  Future<void> updateProfile(UserProfile profile) async {
    try {
      await HiveService.userProfileBox.put(_key, profile);
    } catch (_) {
      throw const StorageException('Could not update profile.');
    }
  }

  Future<void> incrementTripsCompleted() async {
    final profile = getProfile();
    await updateProfile(profile.copyWith(tripsCompleted: profile.tripsCompleted + 1));
  }
}
