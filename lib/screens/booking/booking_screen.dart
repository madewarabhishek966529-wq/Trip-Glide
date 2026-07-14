import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../models/booking.dart';
import '../../providers/booking_provider.dart';
import '../../providers/destination_provider.dart';
import '../../widgets/app_button.dart';
import '../../widgets/error_view.dart';
import '../../widgets/guest_stepper.dart';
import 'widgets/date_selector.dart';
import 'widgets/price_summary.dart';
import 'widgets/time_selector.dart';

/// The booking flow: date + time + guest count -> live price calculation
/// -> confirm -> confirmation dialog. All draft state lives in
/// [BookingProvider] so leaving and returning to this screen (e.g. via
/// back button) doesn't silently lose progress within the same session.
class BookingScreen extends StatefulWidget {
  final String destinationId;
  const BookingScreen({super.key, required this.destinationId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingProvider>().startDraft();
  }

  Future<void> _confirm() async {
    final destination = context.read<DestinationProvider>().byId(widget.destinationId);
    if (destination == null) return;

    final bookingProvider = context.read<BookingProvider>();
    final booking = await bookingProvider.confirmBooking(destination);

    if (!mounted) return;

    if (booking == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(bookingProvider.errorMessage ?? 'Could not complete booking.')),
      );
      return;
    }

    await _showConfirmation(booking);
  }

  Future<void> _showConfirmation(Booking booking) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 40),
        title: const Text('Booking confirmed!'),
        content: Text(
          'Your trip for ${booking.guests} guest${booking.guests > 1 ? 's' : ''} on '
          '${booking.date.month}/${booking.date.day}/${booking.date.year} at ${booking.time} is all set.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // dialog
              Navigator.of(context).pop(); // booking screen
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destination = context.watch<DestinationProvider>().byId(widget.destinationId);
    final booking = context.watch<BookingProvider>();

    if (destination == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: ErrorView(message: 'This destination could not be found.')),
      );
    }

    final total = booking.calculateTotal(destination);

    return Scaffold(
      appBar: AppBar(title: Text('Book ${destination.city}')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.spaceLg),
          children: [
            DateSelector(selectedDate: booking.draftDate, onDateSelected: booking.setDraftDate),
            const SizedBox(height: AppConstants.spaceLg),
            TimeSelector(selectedTime: booking.draftTime, onTimeSelected: booking.setDraftTime),
            const SizedBox(height: AppConstants.spaceLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Guests', style: Theme.of(context).textTheme.bodySmall),
                GuestStepper(
                  value: booking.draftGuests,
                  min: AppConstants.minGuestsPerBooking,
                  max: AppConstants.maxGuestsPerBooking,
                  onIncrement: booking.incrementGuests,
                  onDecrement: booking.decrementGuests,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spaceXl),
            PriceSummary(destination: destination, guests: booking.draftGuests, total: total),
            const SizedBox(height: AppConstants.spaceXl),
            PrimaryButton(
              label: 'Confirm booking',
              isLoading: booking.isSubmitting,
              onPressed: booking.isDraftValid ? _confirm : null,
            ),
            if (!booking.isDraftValid)
              Padding(
                padding: const EdgeInsets.only(top: AppConstants.spaceSm),
                child: Text(
                  'Select a date to continue.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
