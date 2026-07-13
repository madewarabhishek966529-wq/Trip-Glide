import 'package:flutter/material.dart';

import '../../core/constants.dart';

/// Placeholder body for a tab that hasn't been built yet in this
/// stage-by-stage rebuild. Deliberately labeled as such rather than
/// dressed up as a finished screen — it will be replaced in an upcoming
/// stage per the agreed build plan.
class ComingSoonScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String stageNote;

  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.stageNote,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spaceXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(height: AppConstants.spaceLg),
              Text(
                stageNote,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
