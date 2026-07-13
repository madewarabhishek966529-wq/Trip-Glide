import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../core/utils/formatters.dart';
import '../../models/booking.dart';
import '../../models/destination.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/app_button.dart';
import 'widgets/date_selector.dart';
import 'widgets/guest_counter.dart';
import 'widgets/price_summary.dart';
import 'widgets/time_selector.dart';

class BookingScreen extends StatefulWidget {
  final Destination destination;

  const BookingScreen({super.key, required this.destination});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().startDraft();
    });
  }

  Future<void> _confirm(BuildContext context) async {
    final provider = context.read<BookingProvider>();
    if (!provider.isDraftValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date before confirming.')),
      );
      return;
    }
    final booking = await provider.confirmBooking(widget.destination);
    if (!mounted) return;
    if (booking != null) {
      await _showConfirmation(context, booking);
    } else if (provider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.errorMessage!)));
    }
  }

  Future<void> _showConfirmation(BuildContext context, Booking booking) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 40),
        title: const Text('Booking confirmed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.destination.city}, ${widget.destination.country}',
                style: Theme.of(dialogContext).textTheme.titleMedium),
            const SizedBox(height: AppConstants.spaceSm),
            Text(AppFormatters.dateWithWeekday(booking.date)),
            Text('${booking.time} \u00b7 ${AppFormatters.guestCount(booking.guests)}'),
            const SizedBox(height: AppConstants.spaceSm),
            Text(
              'Total paid: ${AppFormatters.currency(booking.totalPrice)}',
              style: Theme.of(dialogContext).textTheme.titleMedium,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Done',
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context)
                  ..pop() // close BookingScreen
                  ..pop(); // close DetailsScreen, back to the tab list
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final d = widget.destination;

    return Scaffold(
      appBar: AppBar(title: const Text('Book your trip')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.spaceLg),
          children: [
            _DestinationSummary(destination: d),
            const SizedBox(height: AppConstants.spaceXl),
            DateSelector(selectedDate: booking.draftDate, onDateSelected: booking.setDraftDate),
            const SizedBox(height: AppConstants.spaceXl),
            TimeSelector(selectedTime: booking.draftTime, onTimeSelected: booking.setDraftTime),
            const SizedBox(height: AppConstants.spaceXl),
            GuestCounter(
              value: booking.draftGuests,
              onIncrement: booking.incrementGuests,
              onDecrement: booking.decrementGuests,
            ),
            const SizedBox(height: AppConstants.spaceXl),
            PriceSummary(destination: d, guests: booking.draftGuests),
            const SizedBox(height: AppConstants.spaceXl),
            PrimaryButton(
              label: 'Confirm booking',
              isLoading: booking.isSubmitting,
              onPressed: () => _confirm(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationSummary extends StatelessWidget {
  final Destination destination;
  const _DestinationSummary({required this.destination});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceSm),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            child: CachedNetworkImage(
              imageUrl: destination.coverImage,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppConstants.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(destination.city, style: Theme.of(context).textTheme.titleMedium),
                Text(destination.country, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Text(
            AppFormatters.currency(destination.price),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
