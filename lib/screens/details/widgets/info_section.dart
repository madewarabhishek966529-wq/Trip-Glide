import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../models/destination.dart';
import '../../../widgets/info_row.dart';

/// Location + trip-facts panel. The weather tile is intentionally a
/// placeholder (no live weather API is wired into this local-first app) —
/// it's labeled as such rather than showing invented numbers.
class InfoSection extends StatelessWidget {
  final Destination destination;

  const InfoSection({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Travel information', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppConstants.spaceSm),
        Container(
          padding: const EdgeInsets.all(AppConstants.spaceMd),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Row(
            children: [
              const Icon(Icons.cloud_outlined, size: 28, color: AppColors.terracotta),
              const SizedBox(width: AppConstants.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Weather', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      'Live forecast isn\u2019t connected yet — check a weather app before you pack.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spaceMd),
        InfoRow(
          icon: Icons.location_on_outlined,
          label: 'Coordinates',
          value: '${destination.latitude.toStringAsFixed(2)}, ${destination.longitude.toStringAsFixed(2)}',
        ),
        InfoRow(
          icon: Icons.sell_outlined,
          label: 'Starting price',
          value: '\$${destination.price.toStringAsFixed(0)} / person',
        ),
        InfoRow(
          icon: Icons.star_outline_rounded,
          label: 'Rating',
          value: '${destination.rating.toStringAsFixed(1)} (${destination.reviewCount})',
        ),
      ],
    );
  }
}
