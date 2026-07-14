import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../core/utils/formatters.dart';
import '../../models/booking.dart';
import '../../providers/booking_provider.dart';
import '../../providers/destination_provider.dart';
import '../../widgets/empty_state.dart';

/// Upcoming + past bookings, split into two tabs.
class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My bookings'),
          bottom: const TabBar(tabs: [Tab(text: 'Upcoming'), Tab(text: 'History')]),
        ),
        body: const TabBarView(
          children: [_BookingList(upcoming: true), _BookingList(upcoming: false)],
        ),
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  final bool upcoming;
  const _BookingList({required this.upcoming});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final destinationProvider = context.watch<DestinationProvider>();
    final bookings = upcoming ? bookingProvider.upcoming : bookingProvider.history;

    if (bookings.isEmpty) {
      return EmptyState(
        icon: upcoming ? Icons.card_travel_rounded : Icons.history_rounded,
        title: upcoming ? 'No upcoming trips' : 'No past trips yet',
        message: upcoming
            ? 'Book a tour from any destination to see it here.'
            : 'Completed and cancelled bookings will show up here.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppConstants.spaceLg),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppConstants.spaceSm),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        final destination = destinationProvider.byId(booking.destinationId);
        return _BookingTile(
          booking: booking,
          destinationName: destination?.fullLocation ?? 'Destination unavailable',
          onCancel: upcoming ? () => bookingProvider.cancelBooking(booking.id) : null,
        );
      },
    );
  }
}

class _BookingTile extends StatelessWidget {
  final Booking booking;
  final String destinationName;
  final VoidCallback? onCancel;

  const _BookingTile({required this.booking, required this.destinationName, this.onCancel});

  Color _statusColor() {
    switch (booking.status) {
      case BookingStatus.upcoming:
        return AppColors.success;
      case BookingStatus.completed:
        return AppColors.terracotta;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }

  String _statusLabel() {
    switch (booking.status) {
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(destinationName, style: Theme.of(context).textTheme.titleMedium)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor().withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppConstants.radiusPill),
                ),
                child: Text(
                  _statusLabel(),
                  style: TextStyle(color: _statusColor(), fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${AppFormatters.dateWithWeekday(booking.date)} · ${booking.time} · ${AppFormatters.guestCount(booking.guests)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(AppFormatters.currency(booking.totalPrice), style: Theme.of(context).textTheme.titleSmall),
          if (onCancel != null) ...[
            const SizedBox(height: AppConstants.spaceSm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: onCancel, child: const Text('Cancel booking')),
            ),
          ],
        ],
      ),
    );
  }
}
