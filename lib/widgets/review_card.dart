import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/utils/formatters.dart';
import '../models/review.dart';
import 'avatar_widget.dart';
import 'rating_badge.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spaceSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarWidget(imageUrl: review.userAvatar, name: review.userName, radius: 20),
          const SizedBox(width: AppConstants.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(review.userName, style: Theme.of(context).textTheme.titleSmall),
                    Text(AppFormatters.dateShort(review.createdAt), style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 2),
                RatingBadge(rating: review.rating, iconSize: 13),
                const SizedBox(height: 6),
                Text(review.comment, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
