import 'package:hive/hive.dart';

/// Tracks the destinations a user has recently opened, most recent first.
class RecentlyViewedEntry {
  final String destinationId;
  final DateTime viewedAt;

  const RecentlyViewedEntry({required this.destinationId, required this.viewedAt});
}

class RecentlyViewedEntryAdapter extends TypeAdapter<RecentlyViewedEntry> {
  @override
  final int typeId = 6;

  @override
  RecentlyViewedEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyViewedEntry(
      destinationId: fields[0] as String,
      viewedAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyViewedEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.destinationId)
      ..writeByte(1)
      ..write(obj.viewedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is RecentlyViewedEntryAdapter && other.typeId == typeId);
}
