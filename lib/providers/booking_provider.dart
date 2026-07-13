import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../core/constants.dart';
import '../core/errors/app_exception.dart';
import '../models/booking.dart';
import '../models/destination.dart';
import '../repositories/booking_repository.dart';

/// Owns two things: the in-progress booking *draft* (date/time/guests as
/// the user fills out the booking form) and the persisted list of
/// bookings (upcoming + history). Keeping the draft here — rather than in
/// screen-local State — means price calculation and validation live in one
/// testable place instead of being duplicated across booking widgets.
class BookingProvider extends ChangeNotifier {
  final BookingRepository _bookingRepo;
  static const _uuid = Uuid();

  BookingProvider({BookingRepository? bookingRepo}) : _bookingRepo = bookingRepo ?? BookingRepository();

  List<Booking> _bookings = [];
  List<Booking> get bookings => _bookings;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  // --- Draft state for the active booking flow ---
  DateTime? _draftDate;
  DateTime? get draftDate => _draftDate;

  String _draftTime = '10:00 AM';
  String get draftTime => _draftTime;

  int _draftGuests = 1;
  int get draftGuests => _draftGuests;

  void load() {
    try {
      _bookings = _bookingRepo.getAll();
      _errorMessage = null;
    } on AppException catch (e) {
      _errorMessage = e.message;
    }
    notifyListeners();
  }

  void startDraft() {
    _draftDate = null;
    _draftTime = '10:00 AM';
    _draftGuests = 1;
    notifyListeners();
  }

  void setDraftDate(DateTime date) {
    _draftDate = date;
    notifyListeners();
  }

  void setDraftTime(String time) {
    _draftTime = time;
    notifyListeners();
  }

  void incrementGuests() {
    if (_draftGuests < AppConstants.maxGuestsPerBooking) {
      _draftGuests++;
      notifyListeners();
    }
  }

  void decrementGuests() {
    if (_draftGuests > AppConstants.minGuestsPerBooking) {
      _draftGuests--;
      notifyListeners();
    }
  }

  double calculateTotal(Destination destination) => destination.price * _draftGuests;

  bool get isDraftValid => _draftDate != null && _draftGuests >= AppConstants.minGuestsPerBooking;

  /// Persists the current draft as a new booking. Returns the created
  /// [Booking] on success, or `null` if it failed (check [errorMessage]).
  Future<Booking?> confirmBooking(Destination destination) async {
    if (!isDraftValid) {
      _errorMessage = 'Please select a date before booking.';
      notifyListeners();
      return null;
    }

    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final booking = Booking(
        id: _uuid.v4(),
        destinationId: destination.id,
        date: _draftDate!,
        time: _draftTime,
        guests: _draftGuests,
        totalPrice: calculateTotal(destination),
        status: BookingStatus.upcoming,
        createdAt: DateTime.now(),
      );
      await _bookingRepo.create(booking);
      _bookings = _bookingRepo.getAll();
      _isSubmitting = false;
      notifyListeners();
      return booking;
    } on AppException catch (e) {
      _errorMessage = e.message;
      _isSubmitting = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> cancelBooking(String id) async {
    try {
      await _bookingRepo.cancel(id);
      _bookings = _bookingRepo.getAll();
      notifyListeners();
    } on AppException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  Future<void> markCompleted(String id) async {
    final booking = _bookingRepo.getById(id);
    if (booking == null) return;
    try {
      await _bookingRepo.update(booking.copyWith(status: BookingStatus.completed));
      _bookings = _bookingRepo.getAll();
      notifyListeners();
    } on AppException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  List<Booking> get upcoming =>
      _bookings.where((b) => b.status == BookingStatus.upcoming).toList()
        ..sort((a, b) => a.date.compareTo(b.date));

  List<Booking> get history =>
      _bookings.where((b) => b.status != BookingStatus.upcoming).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  int get completedTripCount => _bookings.where((b) => b.status == BookingStatus.completed).length;
}
