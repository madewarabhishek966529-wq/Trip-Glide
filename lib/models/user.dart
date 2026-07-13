import 'package:hive/hive.dart';

/// The local user's profile. Since there is no backend, this is a single
/// record stored under a fixed key in [AppConstants.boxUserProfile].
class UserProfile {
  final String name;
  final String email;
  final String avatar;
  final int tripsCompleted;
  final DateTime joinedDate;

  const UserProfile({
    required this.name,
    required this.email,
    required this.avatar,
    required this.tripsCompleted,
    required this.joinedDate,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? avatar,
    int? tripsCompleted,
    DateTime? joinedDate,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      tripsCompleted: tripsCompleted ?? this.tripsCompleted,
      joinedDate: joinedDate ?? this.joinedDate,
    );
  }
}

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 4;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      name: fields[0] as String,
      email: fields[1] as String,
      avatar: fields[2] as String,
      tripsCompleted: fields[3] as int,
      joinedDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.avatar)
      ..writeByte(3)
      ..write(obj.tripsCompleted)
      ..writeByte(4)
      ..write(obj.joinedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is UserProfileAdapter && other.typeId == typeId);
}
