import 'package:flutter/material.dart';
import '../core/constants.dart';

/// A section title with an optional trailing "See all" action, used above
/// every horizontal rail on Home (Popular, Recommended, Top rated, etc).
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg, vertical: AppConstants.spaceSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'See all',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
