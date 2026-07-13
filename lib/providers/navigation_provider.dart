import 'package:flutter/foundation.dart';

/// Owns the selected index of the bottom navigation bar. A dedicated
/// provider (rather than a raw `int` in a StatefulWidget) lets any screen
/// programmatically jump tabs — e.g. tapping "See all favorites" from
/// Home switches to the Favorites tab.
class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
