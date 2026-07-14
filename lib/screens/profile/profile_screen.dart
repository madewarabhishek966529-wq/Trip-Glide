import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../providers/user_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/avatar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final profile = user.profile;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: profile == null
            ? Center(child: Text(user.errorMessage ?? 'No profile found.'))
            : ListView(
                padding: const EdgeInsets.all(AppConstants.spaceLg),
                children: [
                  Center(
                    child: Column(
                      children: [
                        AvatarWidget(imageUrl: profile.avatar, name: profile.name, radius: 44),
                        const SizedBox(height: AppConstants.spaceMd),
                        Text(profile.name, style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 2),
                        Text(profile.email, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceXl),
                  _StatsRow(
                    trips: user.tripsCompleted,
                    favorites: user.favoritesCount,
                  ),
                  const SizedBox(height: AppConstants.spaceXl),
                  _MenuTile(
                    icon: Icons.card_travel_rounded,
                    label: 'My bookings',
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingHistory),
                  ),
                  _MenuTile(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.settings),
                  ),
                  const _MenuTile(icon: Icons.help_outline_rounded, label: 'Help & support'),
                ],
              ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final int trips;
  final int favorites;

  const _StatsRow({required this.trips, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Stat(label: 'Trips', value: '$trips'),
        _VerticalDivider(),
        _Stat(label: 'Favorites', value: '$favorites'),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 36, color: Theme.of(context).dividerColor);
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 2),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _MenuTile({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spaceSm),
      elevation: 0,
      color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusMd)),
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusMd)),
      ),
    );
  }
}
