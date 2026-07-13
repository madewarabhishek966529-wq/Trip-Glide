import 'package:hive/hive.dart';

enum BookingStatus { upcoming, completed, cancelled }

/// A confirmed (or historical) booking created by the user.
class Booking {
  final String id;
  final String destinationId;
  final DateTime date;
  final String time;
  final int guests;
  final double totalPrice;
  final BookingStatus status;
  final DateTime createdAt;

  const Booking({
    required this.id,
    required this.destinationId,
    required this.date,
    required this.time,
    required this.guests,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  Booking copyWith({
    String? id,
    String? destinationId,
    DateTime? date,
    String? time,
    int? guests,
    double? totalPrice,
    BookingStatus? status,
    DateTime? createdAt,
  }) {
    return Booking(
      id: id ?? this.id,
      destinationId: destinationId ?? this.destinationId,
      date: date ?? this.date,
      time: time ?? this.time,
      guests: guests ?? this.guests,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) => other is Booking && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final int typeId = 3;

  @override
  Booking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      id: fields[0] as String,
      destinationId: fields[1] as String,
      date: fields[2] as DateTime,
      time: fields[3] as String,
      guests: fields[4] as int,
      totalPrice: fields[5] as double,
      status: BookingStatus.values[fields[6] as int],
      createdAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.destinationId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.guests)
      ..writeByte(5)
      ..write(obj.totalPrice)
      ..writeByte(6)
      ..write(obj.status.index)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is BookingAdapter && other.typeId == typeId);
}
