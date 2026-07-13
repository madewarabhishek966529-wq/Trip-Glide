import 'package:flutter/material.dart';
import 'core/theme.dart';

class TripGlideApp extends StatelessWidget {
  const TripGlideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TripGlide',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(child: Text('Home Screen Coming Next')),
      ),
    );
  }
}
