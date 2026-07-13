import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'providers/booking_provider.dart';
import 'providers/destination_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/search_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'routes/app_routes.dart';

class TripGlideApp extends StatelessWidget {
  const TripGlideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Navigation is UI-only state and has nothing to load.
        ChangeNotifierProvider(create: (_) => NavigationProvider()),

        // Everything else is backed by a repository over Hive, so it
        // needs an explicit .load() once boxes are open — screens trigger
        // that themselves (e.g. HomeScreen loads Destination/Favorite/User
        // on first frame) rather than doing it here, to keep this widget
        // free of side effects.
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..load()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TripGlide',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: AppRoutes.main,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
