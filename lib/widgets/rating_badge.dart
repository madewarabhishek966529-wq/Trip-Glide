import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/utils/formatters.dart';

/// A compact star + rating readout, e.g. "★ 4.9". Used on cards, detail
/// headers, and review summaries.
class RatingBadge extends StatelessWidget {
  final double rating;
  final double iconSize;
  final TextStyle? style;
  final bool showBackground;

  const RatingBadge({
    super.key,
    required this.rating,
    this.iconSize = 14,
    this.style,
    this.showBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: AppColors.rating, size: iconSize),
        const SizedBox(width: 4),
        Text(
          AppFormatters.rating(rating),
          style: style ?? Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );

    if (!showBackground) return content;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(100),
      ),
      child: content,
    );
  }
}
