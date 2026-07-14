import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import '../../../models/destination.dart';
import '../../../widgets/destination_card.dart';
import '../../../widgets/section_header.dart';

/// A titled horizontal rail of [DestinationCard]s — reused for Popular,
/// Recommended, Top rated, and Recently viewed sections.
class DestinationRail extends StatelessWidget {
  final String title;
  final List<Destination> destinations;
  final ValueChanged<Destination> onTap;
  final VoidCallback? onSeeAll;

  const DestinationRail({
    super.key,
    required this.title,
    required this.destinations,
    required this.onTap,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (destinations.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, onSeeAll: onSeeAll),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
            itemCount: destinations.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppConstants.spaceMd),
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return DestinationCard(
                destination: destination,
                width: 200,
                height: 260,
                onTap: () => onTap(destination),
              );
            },
          ),
        ),
      ],
    );
  }
}
