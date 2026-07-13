/// Simple validation helpers used by forms (booking, profile editing).
class Validators {
  Validators._();

  static String? requiredField(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final pattern = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!pattern.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? guests(int value, {required int min, required int max}) {
    if (value < min) return 'At least $min guest required';
    if (value > max) return 'Maximum $max guests allowed';
    return null;
  }

  static String? futureDate(DateTime? date) {
    if (date == null) return 'Please select a date';
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    if (date.isBefore(normalizedToday)) return 'Date must be in the future';
    return null;
  }
}
