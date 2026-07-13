import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation_provider.dart';
import '../widgets/bottom_navbar.dart';
import 'home/home_screen.dart';
import 'shared/coming_soon_screen.dart';

/// Hosts the four bottom-nav tabs behind a single [Scaffold] so switching
/// tabs never rebuilds the whole navigation stack. Only Home is fully
/// built this stage; Search/Favorites/Profile arrive in the next ones and
/// are wired here as named, honest placeholders rather than silently
/// missing tabs.
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  static const _tabs = [
    HomeScreen(),
    ComingSoonScreen(
      title: 'Search',
      icon: Icons.search_rounded,
      stageNote: 'Instant search with country, city, category, and rating '
          'filters is built next, on top of the SearchProvider already wired '
          'in this stage.',
    ),
    ComingSoonScreen(
      title: 'Favorites',
      icon: Icons.favorite_rounded,
      stageNote: 'Your saved destinations will appear here — favoriting '
          'already works from any destination card, this tab just needs '
          'its list view.',
    ),
    ComingSoonScreen(
      title: 'Profile',
      icon: Icons.person_rounded,
      stageNote: 'Profile details, trip stats, and the Settings shortcut '
          'are built on top of the UserProvider already wired in this stage.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, nav, _) {
        return Scaffold(
          body: IndexedStack(index: nav.currentIndex, children: _tabs),
          bottomNavigationBar: CustomBottomNavBar(
            index: nav.currentIndex,
            onTap: nav.setIndex,
          ),
        );
      },
    );
  }
}
