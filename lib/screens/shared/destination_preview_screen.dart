import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../core/utils/formatters.dart';
import '../../models/destination.dart';
import '../../providers/destination_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../widgets/app_button.dart';
import '../../widgets/rating_badge.dart';

/// Shown when a destination card is tapped. It carries the real Hero
/// transition and real destination data (no placeholder content), but the
/// full gallery / reviews / booking flow described in the project brief is
/// its own stage — this screen keeps that scope honest instead of faking
/// a "complete" details page ahead of that work.
class DestinationPreviewScreen extends StatefulWidget {
  final Destination destination;

  const DestinationPreviewScreen({super.key, required this.destination});

  @override
  State<DestinationPreviewScreen> createState() => _DestinationPreviewScreenState();
}

class _DestinationPreviewScreenState extends State<DestinationPreviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DestinationProvider>().recordView(widget.destination.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleIconButton(
                icon: Icons.arrow_back_rounded,
                onPressed: () => Navigator.of(context).pop(),
                background: Colors.black38,
                foreground: Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Consumer<FavoriteProvider>(
                  builder: (context, favorites, _) {
                    final isFavorite = favorites.isFavorite(d.id);
                    return CircleIconButton(
                      icon: isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      onPressed: () => favorites.toggle(d.id),
                      background: Colors.black38,
                      foreground: isFavorite ? AppColors.terracotta : Colors.white,
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'destination_image_${d.id}',
                child: CachedNetworkImage(imageUrl: d.coverImage, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.city, style: Theme.of(context).textTheme.headlineLarge),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 16, color: AppColors.terracotta),
                                const SizedBox(width: 4),
                                Text(d.country, style: Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RatingBadge(rating: d.rating, iconSize: 18),
                          const SizedBox(height: 4),
                          Text(AppFormatters.reviewCount(d.reviewCount), style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  Text('About', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppConstants.spaceSm),
                  Text(d.description, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: AppConstants.spaceLg),
                  Wrap(
                    spacing: AppConstants.spaceSm,
                    runSpacing: AppConstants.spaceSm,
                    children: d.tags
                        .map((t) => Chip(label: Text(t)))
                        .toList(growable: false),
                  ),
                  const SizedBox(height: AppConstants.spaceXl),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppConstants.spaceLg,
            AppConstants.spaceSm,
            AppConstants.spaceLg,
            AppConstants.spaceSm,
          ),
          child: Row(
            children: [
              Text(
                '${AppFormatters.currency(d.price)} / person',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              SizedBox(
                width: 180,
                child: PrimaryButton(
                  label: 'Book a tour',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking flow arrives in the next stage.')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
