import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../core/colors.dart';

/// Circular avatar that falls back to initials if the image URL is empty
/// or fails to load — keeps review lists and the profile header from ever
/// showing a broken-image icon.
class AvatarWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double radius;

  const AvatarWidget({super.key, required this.imageUrl, required this.name, this.radius = 20});

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: imageUrl.isEmpty
            ? _fallback(context)
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => _fallback(context),
                errorWidget: (_, __, ___) => _fallback(context),
              ),
      ),
    );
  }

  Widget _fallback(BuildContext context) {
    return Container(
      color: AppColors.terracotta,
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: radius * 0.7),
      ),
    );
  }
}
