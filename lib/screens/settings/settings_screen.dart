import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SettingsGroup(),
          SizedBox(height:16),
          ThemeTile(),
          Divider(),
          AboutTile(),
        ],
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget{
  const SettingsGroup({super.key});
  @override
  Widget build(BuildContext context){
    return Column(
      children: const [
        SwitchListTile(
          value: true,
          onChanged: null,
          title: Text('Notifications'),
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text('Language'),
          subtitle: Text('English'),
        ),
      ],
    );
  }
}

class ThemeTile extends StatelessWidget{
  const ThemeTile({super.key});
  @override
  Widget build(BuildContext context){
    return const ListTile(
      leading: Icon(Icons.dark_mode),
      title: Text('Theme'),
      subtitle: Text('System'),
    );
  }
}

class AboutTile extends StatelessWidget{
  const AboutTile({super.key});
  @override
  Widget build(BuildContext context){
    return const Column(
      children:[
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About'),
          subtitle: Text('TripGlide Travel App'),
        ),
        ListTile(
          leading: Icon(Icons.privacy_tip_outlined),
          title: Text('Privacy Policy'),
        ),
        ListTile(
          leading: Icon(Icons.verified),
          title: Text('Version'),
          subtitle: Text('1.0.0'),
        ),
      ],
    );
  }
}
