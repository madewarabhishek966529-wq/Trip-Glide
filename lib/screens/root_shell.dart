import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../widgets/bottom_navbar.dart';
import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'favorites/favorites_screen.dart';
import 'profile/profile_screen.dart';

/// Hosts the four main tabs (Home / Search / Favorites / Profile) in an
/// [IndexedStack] so switching tabs preserves each screen's scroll
/// position and state instead of rebuilding from scratch.
class RootShell extends StatelessWidget {
  const RootShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, nav, _) {
        return Scaffold(
          body: IndexedStack(
            index: nav.currentIndex,
            children: const [
              HomeScreen(),
              SearchScreen(),
              FavoritesScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            index: nav.currentIndex,
            onTap: nav.setIndex,
          ),
        );
      },
    );
  }
}
