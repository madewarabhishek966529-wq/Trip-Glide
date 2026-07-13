import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/utils/formatters.dart';
import '../models/destination.dart';
import '../providers/favorite_provider.dart';
import 'rating_badge.dart';
import 'shimmer_box.dart';

/// The primary destination card used across Home, Search, and Favorites.
///
/// [width]/[height] let call sites size it for a horizontal rail (Home's
/// "Popular destinations") vs. a grid (Search results) without needing two
/// separate widgets.
class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;
  final double width;
  final double height;
  final bool showFavoriteButton;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
    this.width = 240,
    this.height = 280,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'destination_image_${destination.id}',
                child: CachedNetworkImage(
                  imageUrl: destination.coverImage,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const ShimmerBox(),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.lightSurfaceAlt,
                    child: const Icon(Icons.image_not_supported_outlined, color: AppColors.lightTextSecondary),
                  ),
                ),
              ),
              // Scrim for text legibility over the photo.
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.imageScrim,
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
              ),
              if (showFavoriteButton)
                Positioned(
                  top: AppConstants.spaceSm,
                  right: AppConstants.spaceSm,
                  child: _FavoriteButton(destinationId: destination.id),
                ),
              Positioned(
                left: AppConstants.spaceMd,
                right: AppConstants.spaceMd,
                bottom: AppConstants.spaceMd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      destination.country,
                      style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      destination.city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        RatingBadge(
                          rating: destination.rating,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            AppFormatters.reviewCount(destination.reviewCount),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final String destinationId;
  const _FavoriteButton({required this.destinationId});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favorites, _) {
        final isFavorite = favorites.isFavorite(destinationId);
        return GestureDetector(
          onTap: () => favorites.toggle(destinationId),
          child: AnimatedContainer(
            duration: AppConstants.animationFast,
            width: 34,
            height: 34,
            decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
            child: AnimatedSwitcher(
              duration: AppConstants.animationFast,
              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
              child: Icon(
                isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                key: ValueKey(isFavorite),
                color: isFavorite ? AppColors.terracotta : Colors.white,
                size: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
