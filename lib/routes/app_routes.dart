import 'package:flutter/material.dart';

import '../core/page_transition.dart';
import '../models/destination.dart';
import '../screens/booking/booking_screen.dart';
import '../screens/details/details_screen.dart';
import '../screens/main_shell.dart';

/// Central route table. Every screen the app can navigate to is named here
/// so navigation calls read as `Navigator.pushNamed(context, AppRoutes.x)`
/// rather than scattering raw string literals (or, worse, direct widget
/// constructors) through screens.
class AppRoutes {
  AppRoutes._();

  static const String main = '/';
  static const String details = '/details';
  static const String booking = '/booking';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return AppPageRoute(page: const MainShell(), type: TransitionType.fade);

      case details:
        final destination = settings.arguments as Destination;
        return AppPageRoute(
          page: DetailsScreen(destination: destination),
          type: TransitionType.slideUp,
        );

      case booking:
        final destination = settings.arguments as Destination;
        return AppPageRoute(
          page: BookingScreen(destination: destination),
          type: TransitionType.slideRight,
        );

      default:
        return AppPageRoute(
          page: Scaffold(
            body: Center(child: Text('No route defined for "${settings.name}"')),
          ),
        );
    }
  }
}
