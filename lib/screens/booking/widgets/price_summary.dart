import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/destination.dart';

/// Line-item breakdown (price per person × guests = total), shown right
/// above the confirm button.
class PriceSummary extends StatelessWidget {
  final Destination destination;
  final int guests;
  final double total;

  const PriceSummary({super.key, required this.destination, required this.guests, required this.total});

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
        children: [
          _line(context, '${AppFormatters.currency(destination.price)} × ${AppFormatters.guestCount(guests)}',
              AppFormatters.currency(destination.price * guests)),
          const Divider(height: AppConstants.spaceLg),
          _line(
            context,
            'Total',
            AppFormatters.currency(total),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _line(BuildContext context, String label, String value, {bool isTotal = false}) {
    final style = isTotal ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style?.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
