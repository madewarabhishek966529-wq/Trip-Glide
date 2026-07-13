import 'package:hive/hive.dart';

/// A single favorited destination, keyed by [destinationId] in Hive so
/// add/remove/lookup are all O(1).
class FavoriteEntry {
  final String destinationId;
  final DateTime addedAt;

  const FavoriteEntry({required this.destinationId, required this.addedAt});
}

class FavoriteEntryAdapter extends TypeAdapter<FavoriteEntry> {
  @override
  final int typeId = 5;

  @override
  FavoriteEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteEntry(
      destinationId: fields[0] as String,
      addedAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.destinationId)
      ..writeByte(1)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is FavoriteEntryAdapter && other.typeId == typeId);
}
