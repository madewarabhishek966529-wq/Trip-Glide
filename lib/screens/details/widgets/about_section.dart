import 'package:flutter/material.dart';

import '../../../core/constants.dart';

/// Description block with a "Read more"/"Read less" toggle so long
/// descriptions don't push the rest of the page down by default.
class AboutSection extends StatefulWidget {
  final String description;

  const AboutSection({super.key, required this.description});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppConstants.spaceSm),
        AnimatedCrossFade(
          firstChild: Text(
            widget.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          secondChild: Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: AppConstants.animationFast,
        ),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _expanded ? 'Read less' : 'Read more',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    );
  }
}
