import 'package:hive/hive.dart';

/// A user review attached to a destination.
class Review {
  final String id;
  final String destinationId;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.destinationId,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) => other is Review && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class ReviewAdapter extends TypeAdapter<Review> {
  @override
  final int typeId = 2;

  @override
  Review read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Review(
      id: fields[0] as String,
      destinationId: fields[1] as String,
      userName: fields[2] as String,
      userAvatar: fields[3] as String,
      rating: fields[4] as double,
      comment: fields[5] as String,
      createdAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Review obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.destinationId)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.userAvatar)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is ReviewAdapter && other.typeId == typeId);
}
