import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants.dart';
import 'core/theme.dart';
import 'providers/booking_provider.dart';
import 'providers/destination_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/search_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'routes/app_routes.dart';

/// App root: registers every provider once, above the [MaterialApp], so
/// any screen can reach it via `context.watch`/`context.read` without
/// re-instantiating repositories.
class TripGlideApp extends StatelessWidget {
  const TripGlideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..load()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => DestinationProvider()..load()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()..load()),
        ChangeNotifierProvider(create: (_) => BookingProvider()..load()),
        ChangeNotifierProvider(create: (_) => UserProvider()..load()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: AppRoutes.root,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
