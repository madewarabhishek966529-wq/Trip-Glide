import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/destination.dart';
import '../../../widgets/info_row.dart';

/// Location, price, and a weather panel. Weather is intentionally a
/// static placeholder card (no external weather API is wired up) rather
/// than a fake live reading, since the app has no network dependency for
/// its core data.
class TravelInfoPanel extends StatelessWidget {
  final Destination destination;
  const TravelInfoPanel({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Travel information', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppConstants.spaceSm),
        InfoRow(icon: Icons.location_on_outlined, label: 'Location', value: destination.fullLocation),
        InfoRow(icon: Icons.sell_outlined, label: 'Price per person', value: AppFormatters.currency(destination.price)),
        InfoRow(icon: Icons.category_outlined, label: 'Highlights', value: destination.tags.take(2).join(', ')),
        const SizedBox(height: AppConstants.spaceMd),
        _WeatherPlaceholder(),
      ],
    );
  }
}

class _WeatherPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          const Icon(Icons.wb_cloudy_outlined, size: 28),
          const SizedBox(width: AppConstants.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weather', style: Theme.of(context).textTheme.titleSmall),
                Text(
                  'Live weather isn\'t connected in this offline build.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
