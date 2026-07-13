import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/destination.dart';
import '../../../widgets/app_button.dart';

/// Sticky bottom bar showing the starting price and the primary "Book a
/// tour" CTA. Kept as its own widget so [DetailsScreen] doesn't need to
/// know about the booking route directly — it just receives a callback.
class BookingButton extends StatelessWidget {
  final Destination destination;
  final VoidCallback onBook;

  const BookingButton({super.key, required this.destination, required this.onBook});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.spaceLg,
          AppConstants.spaceSm,
          AppConstants.spaceLg,
          AppConstants.spaceSm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppFormatters.currency(destination.price),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text('per person', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            SizedBox(
              width: 180,
              child: PrimaryButton(label: 'Book a tour', onPressed: onBook, icon: Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
