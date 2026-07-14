import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../core/utils/formatters.dart';
import '../../providers/destination_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../repositories/review_repository.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_button.dart';
import '../../widgets/error_view.dart';
import '../../widgets/rating_badge.dart';
import 'widgets/about_section.dart';
import 'widgets/gallery.dart';
import 'widgets/review_section.dart';
import 'widgets/travel_info_panel.dart';

/// Destination detail screen: gallery, rating/location header, expandable
/// description, travel info + weather panel, reviews, and a sticky
/// "Book a tour" button — matching the "Iconic Brazil" detail screen in
/// the design reference.
class DetailsScreen extends StatelessWidget {
  final String destinationId;
  const DetailsScreen({super.key, required this.destinationId});

  @override
  Widget build(BuildContext context) {
    final destination = context.watch<DestinationProvider>().byId(destinationId);

    if (destination == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: ErrorView(message: 'This destination could not be found.'),
        ),
      );
    }

    final reviews = ReviewRepository().getForDestination(destinationId);
    final averageRating = reviews.isEmpty
        ? destination.rating
        : reviews.fold<double>(0, (sum, r) => sum + r.rating) / reviews.length;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(bottom: 110),
              children: [
                DetailsGallery(destinationId: destination.id, images: destination.gallery),
                Padding(
                  padding: const EdgeInsets.all(AppConstants.spaceLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(destination.city, style: Theme.of(context).textTheme.headlineLarge),
                                const SizedBox(height: 2),
                                Text(destination.fullLocation, style: Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          RatingBadge(rating: averageRating, showBackground: true),
                        ],
                      ),
                      const SizedBox(height: AppConstants.spaceLg),
                      AboutSection(description: destination.description),
                      const SizedBox(height: AppConstants.spaceXl),
                      TravelInfoPanel(destination: destination),
                      const SizedBox(height: AppConstants.spaceXl),
                      ReviewSection(reviews: reviews, averageRating: averageRating),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: AppConstants.spaceMd,
              left: AppConstants.spaceMd,
              right: AppConstants.spaceMd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    background: Colors.black38,
                    foreground: Colors.white,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Consumer<FavoriteProvider>(
                    builder: (context, favorites, _) => CircleIconButton(
                      icon: favorites.isFavorite(destination.id) ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      background: Colors.black38,
                      foreground: favorites.isFavorite(destination.id) ? const Color(0xFFE07856) : Colors.white,
                      onPressed: () => favorites.toggle(destination.id),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.spaceLg,
                  AppConstants.spaceMd,
                  AppConstants.spaceLg,
                  AppConstants.spaceLg,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -4))],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From', style: Theme.of(context).textTheme.bodySmall),
                        Text(AppFormatters.currency(destination.price), style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                    const SizedBox(width: AppConstants.spaceLg),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Book a tour',
                        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.booking, arguments: destination.id),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
