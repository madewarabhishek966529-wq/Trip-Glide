import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../models/destination.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/destination_card.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/shimmer_box.dart';

/// A titled horizontal-scrolling rail of [DestinationCard]s. Used for every
/// curated section on Home (Popular, Recommended, Top rated, Recently
/// viewed) so those sections are pure composition over this one widget.
class DestinationRail extends StatelessWidget {
  final String title;
  final List<Destination> destinations;
  final bool isLoading;
  final String emptyMessage;
  final VoidCallback? onSeeAll;

  const DestinationRail({
    super.key,
    required this.title,
    required this.destinations,
    this.isLoading = false,
    this.emptyMessage = 'Nothing here yet.',
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          const DestinationRailShimmer(),
        ],
      );
    }

    if (destinations.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          EmptyState(
            icon: Icons.travel_explore_outlined,
            title: 'Nothing here yet',
            message: emptyMessage,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, onSeeAll: onSeeAll),
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
            itemCount: destinations.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppConstants.spaceMd),
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return DestinationCard(
                destination: destination,
                onTap: () => Navigator.of(context).pushNamed(
                  AppRoutes.details,
                  arguments: destination,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
