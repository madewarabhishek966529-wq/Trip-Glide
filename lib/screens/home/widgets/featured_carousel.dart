import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/destination.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/rating_badge.dart';
import '../../../widgets/shimmer_box.dart';

/// The large swipeable "featured" card at the top of Home, matching the
/// hero card in the design reference (full-bleed photo, city/country,
/// rating, "See more" pill button in the bottom-right corner).
class FeaturedCarousel extends StatefulWidget {
  final List<Destination> destinations;
  final ValueChanged<Destination> onSeeMore;

  const FeaturedCarousel({super.key, required this.destinations, required this.onSeeMore});

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  final PageController _controller = PageController(viewportFraction: 1);
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FeaturedCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the category filter changes the list length, snap back to the
    // first card instead of showing a blank/out-of-range page.
    if (oldWidget.destinations != widget.destinations && _page >= widget.destinations.length) {
      _page = 0;
      if (_controller.hasClients) _controller.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.destinations.isEmpty) {
      return const SizedBox(
        height: 420,
        child: Center(child: Text('No destinations in this category yet')),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 420,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.destinations.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
              child: _FeaturedCard(
                destination: widget.destinations[index],
                onSeeMore: () => widget.onSeeMore(widget.destinations[index]),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.destinations.length, (i) {
            final active = i == _page;
            return AnimatedContainer(
              duration: AppConstants.animationFast,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: active ? AppColors.terracotta : Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onSeeMore;

  const _FeaturedCard({required this.destination, required this.onSeeMore});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
              errorWidget: (_, __, ___) => Container(color: AppColors.lightSurfaceAlt),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.imageScrim,
                  stops: const [0.35, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: AppConstants.spaceLg,
            right: AppConstants.spaceLg,
            bottom: AppConstants.spaceLg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(destination.country,
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(
                        destination.city,
                        style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          RatingBadge(
                            rating: destination.rating,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppFormatters.reviewCount(destination.reviewCount),
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppConstants.spaceMd),
                _SeeMoreButton(onTap: onSeeMore),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeeMoreButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SeeMoreButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('See more', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
