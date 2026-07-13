import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../core/exceptions.dart';
import '../../core/hive_boxes.dart';
import '../../models/booking.dart';

class BookingRepository {
  final _uuid = const Uuid();

  Box<Booking> get _box => HiveBoxes.bookings;

  List<Booking> getAll() {
    try {
      return _box.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } on HiveError {
      throw const StorageException('Could not load bookings.');
    }
  }

  Booking getById(String id) {
    final booking = _box.get(id);
    if (booking == null) throw NotFoundException('Booking', id);
    return booking;
  }

  List<Booking> getUpcoming() {
    final now = DateTime.now();
    return getAll()
        .where((b) => b.date.isAfter(now) && b.status != BookingStatus.cancelled)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  Future<Booking> add(Booking booking) async {
    _validate(booking);
    final withId = booking.id.isEmpty ? booking.copyWith(id: _uuid.v4()) : booking;
    try {
      await _box.put(withId.id, withId);
      return withId;
    } on HiveError {
      throw const StorageException('Could not save booking.');
    }
  }

  Future<Booking> updateStatus(String id, BookingStatus status) async {
    final current = getById(id);
    final updated = current.copyWith(status: status);
    try {
      await _box.put(id, updated);
      return updated;
    } on HiveError {
      throw const StorageException('Could not update booking.');
    }
  }

  Future<void> delete(String id) async {
    if (!_box.containsKey(id)) throw NotFoundException('Booking', id);
    try {
      await _box.delete(id);
    } on HiveError {
      throw const StorageException('Could not delete booking.');
    }
  }

  Future<void> clearAll() async {
    try {
      await _box.clear();
    } on HiveError {
      throw const StorageException('Could not clear bookings.');
    }
  }

  void _validate(Booking b) {
    if (b.guests <= 0) throw const ValidationException('Guests must be at least 1.');
    if (b.totalPrice < 0) throw const ValidationException('Total price cannot be negative.');
    if (b.time.trim().isEmpty) throw const ValidationException('Please select a time.');
  }
}
