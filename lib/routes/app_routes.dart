import 'package:flutter/material.dart';

import '../core/page_transition.dart';
import '../models/destination.dart';
import '../screens/main_shell.dart';
import '../screens/shared/destination_preview_screen.dart';

/// Central route table. Every screen the app can navigate to is named here
/// so navigation calls read as `Navigator.pushNamed(context, AppRoutes.x)`
/// rather than scattering raw string literals (or, worse, direct widget
/// constructors) through screens.
class AppRoutes {
  AppRoutes._();

  static const String main = '/';
  static const String destinationPreview = '/destination-preview';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return AppPageRoute(page: const MainShell(), type: TransitionType.fade);

      case destinationPreview:
        final destination = settings.arguments as Destination;
        return AppPageRoute(
          page: DestinationPreviewScreen(destination: destination),
          type: TransitionType.slideUp,
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
