import 'package:hive/hive.dart';

/// A destination category used for home-screen filtering (e.g. Asia,
/// Europe, South America, Beaches, Mountains).
class Category {
  final String id;
  final String name;
  final String icon; // Material icon code point name, resolved in the UI layer

  const Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  Category copyWith({String? id, String? name, String? icon}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool operator ==(Object other) => other is Category && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Hand-written Hive adapter (no build_runner available in this
/// environment). Field order in [write] must match the read order in
/// [read]; each field is preceded by its index so future fields can be
/// appended without breaking older stored records.
class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 0;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      id: fields[0] as String,
      name: fields[1] as String,
      icon: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is CategoryAdapter && other.typeId == typeId);
}
