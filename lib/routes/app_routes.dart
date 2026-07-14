import 'package:flutter/material.dart';
import '../core/page_transition.dart';
import '../screens/details/details_screen.dart';
import '../screens/booking/booking_screen.dart';
import '../screens/booking/booking_history_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/root_shell.dart';

/// Centralized route names + a single [onGenerateRoute] so every
/// `Navigator.pushNamed` call in the app is typo-checked against one
/// source of truth, and argument types are validated in one place instead
/// of scattered `as` casts through the UI layer.
class AppRoutes {
  AppRoutes._();

  static const String root = '/';
  static const String details = '/details';
  static const String booking = '/booking';
  static const String bookingHistory = '/booking-history';
  static const String settings = '/settings';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return AppPageRoute(page: const RootShell(), type: TransitionType.fade);

      case details:
        final destinationId = settings.arguments as String;
        return AppPageRoute(
          page: DetailsScreen(destinationId: destinationId),
          type: TransitionType.slideUp,
        );

      case booking:
        final destinationId = settings.arguments as String;
        return AppPageRoute(
          page: BookingScreen(destinationId: destinationId),
          type: TransitionType.slideUp,
        );

      case bookingHistory:
        return AppPageRoute(page: const BookingHistoryScreen(), type: TransitionType.slideRight);

      case AppRoutes.settings:
        return AppPageRoute(page: const SettingsScreen(), type: TransitionType.slideRight);

      default:
        return AppPageRoute(
          page: Scaffold(
            body: Center(child: Text('Route "${settings.name}" not found')),
          ),
        );
    }
  }
}
