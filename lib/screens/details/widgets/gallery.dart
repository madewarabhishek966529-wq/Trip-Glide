import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../models/destination.dart';
import '../../../widgets/shimmer_box.dart';

/// Full-bleed swipeable photo gallery for the details header. The first
/// photo carries the Hero tag matched to [DestinationCard] so the
/// transition from Home/Search is seamless; the rest of the gallery is
/// reached by swiping.
class DestinationGallery extends StatefulWidget {
  final Destination destination;
  final double height;

  const DestinationGallery({super.key, required this.destination, this.height = 360});

  @override
  State<DestinationGallery> createState() => _DestinationGalleryState();
}

class _DestinationGalleryState extends State<DestinationGallery> {
  final _controller = PageController();
  int _page = 0;

  List<String> get _images {
    final gallery = widget.destination.gallery;
    return gallery.isEmpty ? [widget.destination.coverImage] : gallery;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = _images;
    return SizedBox(
      height: widget.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, index) {
              final image = images[index];
              final child = CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (_, __) => const ShimmerBox(),
              );
              // Only the first photo participates in the shared-element
              // transition — the same photo is what the source card shows.
              if (index == 0) {
                return Hero(
                  tag: 'destination_image_${widget.destination.id}',
                  child: child,
                );
              }
              return child;
            },
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.25), Colors.transparent],
                  stops: const [0.0, 0.3],
                ),
              ),
            ),
          ),
          if (images.length > 1)
            Positioned(
              bottom: AppConstants.spaceMd,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (i) {
                  final active = i == _page;
                  return AnimatedContainer(
                    duration: AppConstants.animationFast,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active ? Colors.white : Colors.white54,
                      borderRadius: BorderRadius.circular(AppConstants.radiusPill),
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
