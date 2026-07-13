import 'package:hive/hive.dart';

/// A bookable travel destination.
class Destination {
  final String id;
  final String city;
  final String country;
  final String categoryId;
  final String coverImage;
  final List<String> gallery;
  final double rating;
  final int reviewCount;
  final double price;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> tags;

  const Destination({
    required this.id,
    required this.city,
    required this.country,
    required this.categoryId,
    required this.coverImage,
    required this.gallery,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.tags,
  });

  String get fullLocation => '$city, $country';

  Destination copyWith({
    String? id,
    String? city,
    String? country,
    String? categoryId,
    String? coverImage,
    List<String>? gallery,
    double? rating,
    int? reviewCount,
    double? price,
    String? description,
    double? latitude,
    double? longitude,
    List<String>? tags,
  }) {
    return Destination(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      categoryId: categoryId ?? this.categoryId,
      coverImage: coverImage ?? this.coverImage,
      gallery: gallery ?? this.gallery,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      price: price ?? this.price,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      tags: tags ?? this.tags,
    );
  }

  @override
  bool operator ==(Object other) => other is Destination && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class DestinationAdapter extends TypeAdapter<Destination> {
  @override
  final int typeId = 1;

  @override
  Destination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Destination(
      id: fields[0] as String,
      city: fields[1] as String,
      country: fields[2] as String,
      categoryId: fields[3] as String,
      coverImage: fields[4] as String,
      gallery: (fields[5] as List).cast<String>(),
      rating: fields[6] as double,
      reviewCount: fields[7] as int,
      price: fields[8] as double,
      description: fields[9] as String,
      latitude: fields[10] as double,
      longitude: fields[11] as double,
      tags: (fields[12] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Destination obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.coverImage)
      ..writeByte(5)
      ..write(obj.gallery)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.reviewCount)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.latitude)
      ..writeByte(11)
      ..write(obj.longitude)
      ..writeByte(12)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is DestinationAdapter && other.typeId == typeId);
}
