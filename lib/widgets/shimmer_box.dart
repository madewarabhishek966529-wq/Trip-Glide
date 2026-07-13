import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/colors.dart';

/// Generic shimmering placeholder rectangle, used both as an image
/// placeholder and standalone in loading-state cards.
class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ShimmerBox({super.key, this.width, this.height, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;
    final highlight = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// A shimmering stand-in for [DestinationCard] while data loads.
class DestinationCardShimmer extends StatelessWidget {
  final double width;
  final double height;

  const DestinationCardShimmer({super.key, this.width = 240, this.height = 280});

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(24),
    );
  }
}

/// A horizontal row of shimmering cards, matching a loading rail section.
class DestinationRailShimmer extends StatelessWidget {
  final int count;
  const DestinationRailShimmer({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: count,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, __) => const DestinationCardShimmer(),
      ),
    );
  }
}
