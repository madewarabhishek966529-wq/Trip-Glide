import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../providers/theme_provider.dart';
import '../../repositories/settings_repository.dart';
import '../../services/hive_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsRepository _settingsRepo = SettingsRepository();
  late bool _notificationsEnabled = _settingsRepo.getNotificationsEnabled();
  late String _language = _settingsRepo.getLanguage();

  static const _languages = ['English', 'Spanish', 'French', 'Portuguese', 'Japanese'];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spaceLg),
        children: [
          Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppConstants.spaceSm),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.light, label: Text('Light'), icon: Icon(Icons.light_mode_outlined)),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dark'), icon: Icon(Icons.dark_mode_outlined)),
              ButtonSegment(value: ThemeMode.system, label: Text('Auto'), icon: Icon(Icons.brightness_auto_outlined)),
            ],
            selected: {themeProvider.themeMode},
            onSelectionChanged: (selection) => themeProvider.setThemeMode(selection.first),
          ),
          const SizedBox(height: AppConstants.spaceXl),
          Text('Preferences', style: Theme.of(context).textTheme.titleMedium),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _notificationsEnabled,
            title: const Text('Notifications'),
            subtitle: const Text('Booking reminders and trip updates'),
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
              _settingsRepo.setNotificationsEnabled(value);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.language_outlined),
            title: const Text('Language'),
            subtitle: Text(_language),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: _pickLanguage,
          ),
          const SizedBox(height: AppConstants.spaceXl),
          Text('About', style: Theme.of(context).textTheme.titleMedium),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.info_outline_rounded),
            title: Text('About TripGlide'),
            subtitle: Text('Your local-first travel companion.'),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Privacy Policy'),
            subtitle: Text('All your data stays on this device.'),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.verified_outlined),
            title: Text('Version'),
            subtitle: Text(AppConstants.appVersion),
          ),
          const SizedBox(height: AppConstants.spaceXl),
          OutlinedButton.icon(
            onPressed: _confirmReset,
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('Reset app data'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickLanguage() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languages
              .map((lang) => ListTile(
                    title: Text(lang),
                    trailing: lang == _language ? const Icon(Icons.check_rounded) : null,
                    onTap: () => Navigator.of(context).pop(lang),
                  ))
              .toList(),
        ),
      ),
    );
    if (selected != null) {
      setState(() => _language = selected);
      await _settingsRepo.setLanguage(selected);
    }
  }

  Future<void> _confirmReset() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset app data?'),
        content: const Text('This clears every favorite, booking, and preference stored on this device. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Reset')),
        ],
      ),
    );
    if (confirmed == true) {
      await HiveService.clearAll();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('App data reset. Restart the app to reseed sample content.')),
        );
      }
    }
  }
}
