import 'package:flutter/material.dart';

/// Route transition styles available across the app. Each screen picks the
/// transition that best matches its navigational relationship to the
/// previous screen (e.g. detail pages slide up, tab-level pages fade).
enum TransitionType { fade, slideUp, slideRight, scale }

class AppPageRoute<T> extends PageRouteBuilder<T> {
  AppPageRoute({
    required Widget page,
    TransitionType type = TransitionType.fade,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
            switch (type) {
              case TransitionType.fade:
                return FadeTransition(opacity: curved, child: child);
              case TransitionType.slideUp:
                return SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(curved),
                  child: FadeTransition(opacity: curved, child: child),
                );
              case TransitionType.slideRight:
                return SlideTransition(
                  position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(curved),
                  child: child,
                );
              case TransitionType.scale:
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
                  child: FadeTransition(opacity: curved, child: child),
                );
            }
          },
        );
}
