import '../core/errors/app_exception.dart';
import '../models/booking.dart';
import '../services/hive_service.dart';

class BookingRepository {
  List<Booking> getAll() {
    try {
      final all = HiveService.bookingsBox.values.toList();
      all.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return all;
    } catch (_) {
      throw const StorageException('Could not load bookings.');
    }
  }

  List<Booking> getUpcoming() => getAll().where((b) => b.status == BookingStatus.upcoming).toList();

  List<Booking> getHistory() =>
      getAll().where((b) => b.status == BookingStatus.completed || b.status == BookingStatus.cancelled).toList();

  Booking? getById(String id) => HiveService.bookingsBox.get(id);

  Future<void> create(Booking booking) async {
    try {
      await HiveService.bookingsBox.put(booking.id, booking);
    } catch (_) {
      throw const StorageException('Could not create booking.');
    }
  }

  Future<void> update(Booking booking) async {
    if (!HiveService.bookingsBox.containsKey(booking.id)) {
      throw const NotFoundException('Booking not found.');
    }
    try {
      await HiveService.bookingsBox.put(booking.id, booking);
    } catch (_) {
      throw const StorageException('Could not update booking.');
    }
  }

  Future<void> cancel(String id) async {
    final booking = HiveService.bookingsBox.get(id);
    if (booking == null) throw const NotFoundException('Booking not found.');
    await update(booking.copyWith(status: BookingStatus.cancelled));
  }

  Future<void> delete(String id) async {
    try {
      await HiveService.bookingsBox.delete(id);
    } catch (_) {
      throw const StorageException('Could not delete booking.');
    }
  }

  int get completedTripCount => getAll().where((b) => b.status == BookingStatus.completed).length;
}
