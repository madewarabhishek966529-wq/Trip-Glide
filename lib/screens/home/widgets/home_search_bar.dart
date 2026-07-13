import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/navigation_provider.dart';
import '../../../widgets/search_field.dart';

/// The Home screen's search entry point. It doesn't run search itself —
/// tapping it hands off to the Search tab (and its dedicated
/// SearchProvider), matching how the design reference treats Home's search
/// bar as a launcher rather than an inline results list.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<NavigationProvider>().setIndex(1),
      child: AbsorbPointer(
        absorbing: true,
        child: SearchField(
          hintText: 'Search destinations',
          onFilterTap: () => context.read<NavigationProvider>().setIndex(1),
        ),
      ),
    );
  }
}
