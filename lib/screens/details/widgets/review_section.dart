import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/review.dart';
import '../../../widgets/rating_badge.dart';
import '../../../widgets/review_card.dart';

/// Average-rating header + a capped list of reviews with a "See all"
/// expansion, rather than a separate reviews screen.
class ReviewSection extends StatefulWidget {
  final List<Review> reviews;
  final double averageRating;

  const ReviewSection({super.key, required this.reviews, required this.averageRating});

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  bool _showAll = false;
  static const _collapsedCount = 3;

  @override
  Widget build(BuildContext context) {
    final visible = _showAll ? widget.reviews : widget.reviews.take(_collapsedCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews', style: Theme.of(context).textTheme.titleLarge),
            if (widget.reviews.isNotEmpty)
              Row(
                children: [
                  RatingBadge(rating: widget.averageRating),
                  const SizedBox(width: 6),
                  Text(
                    '(${AppFormatters.reviewCount(widget.reviews.length)})',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: AppConstants.spaceSm),
        if (widget.reviews.isEmpty)
          Text('No reviews yet — be the first to visit and share your trip.', style: Theme.of(context).textTheme.bodyMedium)
        else ...[
          for (final review in visible) ReviewCard(review: review),
          if (widget.reviews.length > _collapsedCount)
            GestureDetector(
              onTap: () => setState(() => _showAll = !_showAll),
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _showAll ? 'Show less' : 'See all ${widget.reviews.length} reviews',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
