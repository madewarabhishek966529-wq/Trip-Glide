class Booking {
  final String destinationId;
  final DateTime date;
  final String time;
  final int guests;
  final double totalPrice;

  const Booking({
    required this.destinationId,
    required this.date,
    required this.time,
    required this.guests,
    required this.totalPrice,
  });
}
