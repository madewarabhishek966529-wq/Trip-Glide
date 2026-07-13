import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../models/review.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/rating_badge.dart';
import '../../../widgets/review_card.dart';

/// Reviews section: average-rating summary header plus the individual
/// review cards for this destination. Reviews are static seed content in
/// this version of the app (no "write a review" flow yet), so this widget
/// just renders what [ReviewRepository] returns.
class ReviewList extends StatelessWidget {
  final List<Review> reviews;
  final double averageRating;

  const ReviewList({super.key, required this.reviews, required this.averageRating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews', style: Theme.of(context).textTheme.titleLarge),
            if (reviews.isNotEmpty)
              RatingBadge(rating: averageRating, showBackground: true),
          ],
        ),
        const SizedBox(height: AppConstants.spaceSm),
        if (reviews.isEmpty)
          const EmptyState(
            icon: Icons.rate_review_outlined,
            title: 'No reviews yet',
            message: 'Be the first to visit and share your experience.',
          )
        else
          Column(
            children: reviews
                .take(5)
                .map((r) => ReviewCard(review: r))
                .toList(growable: false),
          ),
      ],
    );
  }
}
