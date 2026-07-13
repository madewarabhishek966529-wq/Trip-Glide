import 'package:hive/hive.dart';
import '../core/constants.dart';

/// Named UserProfile (not User) to avoid clashing with any platform/package
/// type named User, and to make its purpose — the single local profile
/// record — unambiguous at call sites.
class UserProfile extends HiveObject {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String? phone;
  final String? bio;
  final DateTime joinedDate;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.phone,
    this.bio,
    required this.joinedDate,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? phone,
    String? bio,
    DateTime? joinedDate,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      joinedDate: joinedDate ?? this.joinedDate,
    );
  }

  @override
  String toString() => 'UserProfile(id: $id, name: $name)';
}

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = HiveTypeIds.userProfile;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      avatarUrl: fields[3] as String,
      phone: fields[4] as String?,
      bio: fields[5] as String?,
      joinedDate: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.avatarUrl)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.bio)
      ..writeByte(6)
      ..write(obj.joinedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
