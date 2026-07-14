import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants.dart';
import '../../../providers/user_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/search_field.dart';

/// "Hello, {name}" greeting + avatar + search bar, matching the top of the
/// design reference's home screen.
class HomeHeader extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterTap;

  const HomeHeader({super.key, required this.onSearchChanged, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<UserProvider>().profile;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spaceLg,
        AppConstants.spaceMd,
        AppConstants.spaceLg,
        AppConstants.spaceMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, ${profile?.name.split(' ').first ?? 'there'}',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 2),
                    Text(AppConstants.appTagline, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.settings),
                child: AvatarWidget(
                  imageUrl: profile?.avatar ?? '',
                  name: profile?.name ?? '?',
                  radius: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spaceLg),
          SearchField(
            hintText: 'Search destinations',
            onChanged: onSearchChanged,
            onFilterTap: onFilterTap,
          ),
        ],
      ),
    );
  }
}
