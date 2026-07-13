import 'package:intl/intl.dart';

/// Shared formatting helpers so date/currency formatting is consistent
/// across booking, details, and history screens.
class AppFormatters {
  AppFormatters._();

  static final DateFormat _dayMonth = DateFormat('MMM d');
  static final DateFormat _dayMonthYear = DateFormat('MMM d, yyyy');
  static final DateFormat _weekdayDayMonth = DateFormat('EEE, MMM d');

  static String currency(double amount, {String symbol = '\$'}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: amount.truncateToDouble() == amount ? 0 : 2);
    return formatter.format(amount);
  }

  static String date(DateTime date) => _dayMonthYear.format(date);

  static String dateShort(DateTime date) => _dayMonth.format(date);

  static String dateWithWeekday(DateTime date) => _weekdayDayMonth.format(date);

  static String dateRange(DateTime start, DateTime end) {
    if (start.year == end.year) {
      return '${_weekdayDayMonth.format(start)} – ${_weekdayDayMonth.format(end)}';
    }
    return '${_dayMonthYear.format(start)} – ${_dayMonthYear.format(end)}';
  }

  static String rating(double value) => value.toStringAsFixed(1);

  static String reviewCount(int count) {
    if (count == 0) return 'No reviews yet';
    if (count == 1) return '1 review';
    return '$count reviews';
  }

  static String guestCount(int count) => count == 1 ? '1 guest' : '$count guests';
}
