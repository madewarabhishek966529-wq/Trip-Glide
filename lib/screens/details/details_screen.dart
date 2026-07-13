import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../models/destination.dart';
import '../../providers/destination_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../repositories/review_repository.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_button.dart';
import '../../widgets/rating_badge.dart';
import 'widgets/about_section.dart';
import 'widgets/booking_button.dart';
import 'widgets/gallery.dart';
import 'widgets/info_section.dart';
import 'widgets/review_list.dart';

class DetailsScreen extends StatefulWidget {
  final Destination destination;

  const DetailsScreen({super.key, required this.destination});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _reviewRepo = ReviewRepository();

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
    final reviews = _reviewRepo.getForDestination(d.id);
    final avgRating = _reviewRepo.averageRating(d.id);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: DestinationGallery(destination: d)),
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
                              RatingBadge(rating: avgRating > 0 ? avgRating : d.rating, iconSize: 18),
                              const SizedBox(height: 4),
                              Text(
                                reviews.isEmpty ? 'No reviews yet' : '${reviews.length} reviews',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.spaceLg),
                      Wrap(
                        spacing: AppConstants.spaceSm,
                        runSpacing: AppConstants.spaceSm,
                        children: d.tags.map((t) => Chip(label: Text(t))).toList(growable: false),
                      ),
                      const SizedBox(height: AppConstants.spaceLg),
                      AboutSection(description: d.description),
                      const SizedBox(height: AppConstants.spaceXl),
                      InfoSection(destination: d),
                      const SizedBox(height: AppConstants.spaceXl),
                      ReviewList(reviews: reviews, averageRating: avgRating),
                      const SizedBox(height: AppConstants.spaceXxl),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: AppConstants.spaceSm,
            left: AppConstants.spaceMd,
            child: SafeArea(
              child: CircleIconButton(
                icon: Icons.arrow_back_rounded,
                onPressed: () => Navigator.of(context).pop(),
                background: Colors.black38,
                foreground: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: AppConstants.spaceSm,
            right: AppConstants.spaceMd,
            child: SafeArea(
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
          ),
        ],
      ),
      bottomNavigationBar: BookingButton(
        destination: d,
        onBook: () => Navigator.of(context).pushNamed(AppRoutes.booking, arguments: d),
      ),
    );
  }
}
