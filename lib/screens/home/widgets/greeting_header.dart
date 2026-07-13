import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/avatar_widget.dart';

/// "Hello, {name}" header with avatar, matching the design reference's
/// Home screen top bar.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final profile = user.profile;
    final firstName = profile != null ? profile.name.split(' ').first : 'there';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, $firstName', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 2),
              Text(AppConstants.appTagline, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        const SizedBox(width: AppConstants.spaceMd),
        AvatarWidget(
          imageUrl: profile?.avatar ?? '',
          name: profile?.name ?? '?',
          radius: 24,
        ),
      ],
    );
  }
}
