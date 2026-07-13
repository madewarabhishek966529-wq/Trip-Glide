import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../providers/destination_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/user_provider.dart';
import '../../repositories/category_repository.dart';
import '../../widgets/error_view.dart';
import 'widgets/category_filter_row.dart';
import 'widgets/destination_rail.dart';
import 'widgets/greeting_header.dart';
import 'widgets/home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _categoryRepo = CategoryRepository();

  @override
  void initState() {
    super.initState();
    // Kick off every provider's initial load once, right after this
    // screen's first frame — not in build(), so a rebuild never
    // re-triggers a Hive read.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DestinationProvider>().load();
      context.read<FavoriteProvider>().load();
      context.read<UserProvider>().load();
    });
  }

  Future<void> _refresh() async {
    context.read<DestinationProvider>().load();
    context.read<FavoriteProvider>().load();
  }

  @override
  Widget build(BuildContext context) {
    final destinations = context.watch<DestinationProvider>();
    final favorites = context.watch<FavoriteProvider>();

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Builder(
            builder: (context) {
              if (destinations.status == LoadStatus.error) {
                return ErrorView(
                  message: destinations.errorMessage ?? 'Could not load destinations.',
                  onRetry: () => context.read<DestinationProvider>().load(),
                );
              }

              final isLoading = destinations.status == LoadStatus.initial ||
                  destinations.status == LoadStatus.loading;

              final categoryFiltered = destinations.filteredByCategory;
              final popular = destinations.selectedCategoryId.isEmpty
                  ? destinations.popular
                  : categoryFiltered;
              final excludeFromRecommended = [
                ...favorites.favoriteIds,
                ...destinations.recentlyViewed.map((d) => d.id),
              ];
              final recommended = destinations.recommendedExcluding(excludeFromRecommended);
              final topRated = destinations.topRated;
              final recentlyViewed = destinations.recentlyViewed;

              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: AppConstants.spaceMd),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
                    child: const GreetingHeader(),
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
                    child: const HomeSearchBar(),
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
                    child: Text('Select your next trip', style: Theme.of(context).textTheme.titleLarge),
                  ),
                  const SizedBox(height: AppConstants.spaceSm),
                  CategoryFilterRow(categories: _categoryRepo.getAll()),
                  const SizedBox(height: AppConstants.spaceLg),
                  DestinationRail(
                    title: destinations.selectedCategoryId.isEmpty ? 'Popular destinations' : 'Filtered results',
                    destinations: popular,
                    isLoading: isLoading,
                    emptyMessage: 'No destinations in this category yet.',
                    onSeeAll: () => context.read<DestinationProvider>().selectCategory(''),
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  DestinationRail(
                    title: 'Recommended for you',
                    destinations: recommended,
                    isLoading: isLoading,
                    emptyMessage: 'Favorite a few places to sharpen your recommendations.',
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  DestinationRail(
                    title: 'Top rated',
                    destinations: topRated,
                    isLoading: isLoading,
                    emptyMessage: 'No ratings yet.',
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  DestinationRail(
                    title: 'Recently viewed',
                    destinations: recentlyViewed,
                    isLoading: false,
                    emptyMessage: 'Places you open will show up here.',
                  ),
                  const SizedBox(height: AppConstants.spaceXxl),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
