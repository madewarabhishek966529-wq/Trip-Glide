import 'package:hive/hive.dart';

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../../core/hive_boxes.dart';
import '../../models/user_profile.dart';

/// The app has exactly one local profile, so this box always holds a single
/// record under [AppConstants.userProfileKey] rather than a list.
class UserRepository {
  Box<UserProfile> get _box => HiveBoxes.userProfile;

  UserProfile? getProfile() {
    try {
      return _box.get(AppConstants.userProfileKey);
    } on HiveError {
      throw const StorageException('Could not load your profile.');
    }
  }

  Future<UserProfile> saveProfile(UserProfile profile) async {
    _validate(profile);
    try {
      await _box.put(AppConstants.userProfileKey, profile);
      return profile;
    } on HiveError {
      throw const StorageException('Could not save your profile.');
    }
  }

  Future<void> clear() async {
    try {
      await _box.delete(AppConstants.userProfileKey);
    } on HiveError {
      throw const StorageException('Could not clear your profile.');
    }
  }

  void _validate(UserProfile p) {
    if (p.name.trim().isEmpty) throw const ValidationException('Name is required.');
    if (!p.email.contains('@')) throw const ValidationException('Enter a valid email.');
  }
}
