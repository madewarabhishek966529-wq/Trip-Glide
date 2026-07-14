import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../widgets/shimmer_box.dart';

/// Full-bleed swipeable photo gallery at the top of the details screen,
/// with the same Hero tag as the card it was opened from so the image
/// transitions smoothly.
class DetailsGallery extends StatefulWidget {
  final String destinationId;
  final List<String> images;

  const DetailsGallery({super.key, required this.destinationId, required this.images});

  @override
  State<DetailsGallery> createState() => _DetailsGalleryState();
}

class _DetailsGalleryState extends State<DetailsGallery> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, index) {
              final image = widget.images[index];
              final child = CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) => const ShimmerBox(),
                errorWidget: (_, __, ___) => Container(color: AppColors.lightSurfaceAlt),
              );
              return index == 0 ? Hero(tag: 'destination_image_${widget.destinationId}', child: child) : child;
            },
          ),
          Positioned(
            bottom: AppConstants.spaceMd,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (i) {
                final active = i == _page;
                return AnimatedContainer(
                  duration: AppConstants.animationFast,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 16 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
