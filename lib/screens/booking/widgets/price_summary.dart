import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/destination.dart';

/// Line-item price breakdown (per-person rate x guests = total), shown
/// above the confirm button so the total is never a surprise.
class PriceSummary extends StatelessWidget {
  final Destination destination;
  final int guests;

  const PriceSummary({super.key, required this.destination, required this.guests});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = destination.price * guests;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        children: [
          _row(context, '${AppFormatters.currency(destination.price)} x ${AppFormatters.guestCount(guests)}',
              AppFormatters.currency(total)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppConstants.spaceSm),
            child: Divider(height: 1),
          ),
          _row(context, 'Total', AppFormatters.currency(total), emphasize: true),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value, {bool emphasize = false}) {
    final labelStyle = emphasize
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.bodyMedium;
    final valueStyle = emphasize
        ? Theme.of(context).textTheme.headlineSmall
        : Theme.of(context).textTheme.titleSmall;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        Text(value, style: valueStyle),
      ],
    );
  }
}
