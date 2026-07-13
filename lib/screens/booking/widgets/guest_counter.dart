import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../widgets/guest_stepper.dart';

class GuestCounter extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const GuestCounter({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Guests', style: Theme.of(context).textTheme.titleLarge),
            Text(
              'Up to ${AppConstants.maxGuestsPerBooking} per booking',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        GuestStepper(
          value: value,
          min: AppConstants.minGuestsPerBooking,
          max: AppConstants.maxGuestsPerBooking,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
        ),
      ],
    );
  }
}
