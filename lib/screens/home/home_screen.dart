import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../models/category.dart';
import '../../models/destination.dart';
import '../../providers/destination_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/search_provider.dart';
import '../../repositories/category_repository.dart';
import '../../routes/app_routes.dart';
import '../../widgets/error_view.dart';
import '../../widgets/shimmer_box.dart';
import 'widgets/category_row.dart';
import 'widgets/destination_rail.dart';
import 'widgets/featured_carousel.dart';
import 'widgets/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryRepository _categoryRepo = CategoryRepository();
  late final List<Category> _categories = _categoryRepo.getAll();

  void _openDestination(Destination destination) {
    context.read<DestinationProvider>().recordView(destination.id);
    Navigator.of(context).pushNamed(AppRoutes.details, arguments: destination.id);
  }

  void _onSearchChanged(String value) {
    if (value.trim().isEmpty) return;
    context.read<SearchProvider>().updateQuery(value);
    context.read<NavigationProvider>().setIndex(1);
  }

  void _openFilters() {
    context.read<NavigationProvider>().setIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    final destinationProvider = context.watch<DestinationProvider>();
    final favoriteIds = context.watch<FavoriteProvider>().favoriteIds;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => destinationProvider.load(),
          child: _buildBody(destinationProvider, favoriteIds),
        ),
      ),
    );
  }

  Widget _buildBody(DestinationProvider provider, Set<String> favoriteIds) {
    if (provider.status == LoadStatus.loading || provider.status == LoadStatus.initial) {
      return ListView(
        children: const [
          SizedBox(height: 120),
          DestinationRailShimmer(),
          SizedBox(height: 24),
          DestinationRailShimmer(),
        ],
      );
    }

    if (provider.status == LoadStatus.error) {
      return Center(
        child: ErrorView(message: provider.errorMessage ?? 'Failed to load destinations.', onRetry: provider.load),
      );
    }

    final featured = provider.selectedCategoryId.isEmpty
        ? provider.popular
        : provider.filteredByCategory;

    final recentlyViewedIds = provider.recentlyViewed.map((d) => d.id).toList();
    final recommended = provider.recommendedExcluding([...favoriteIds, ...recentlyViewedIds]);

    return ListView(
      children: [
        HomeHeader(onSearchChanged: _onSearchChanged, onFilterTap: _openFilters),
        FeaturedCarousel(destinations: featured, onSeeMore: _openDestination),
        const SizedBox(height: AppConstants.spaceLg),
        CategoryRow(
          categories: _categories,
          selectedId: provider.selectedCategoryId,
          onSelect: provider.selectCategory,
        ),
        const SizedBox(height: AppConstants.spaceLg),
        DestinationRail(
          title: 'Recommended for you',
          destinations: recommended,
          onTap: _openDestination,
        ),
        const SizedBox(height: AppConstants.spaceLg),
        DestinationRail(
          title: 'Top rated',
          destinations: provider.topRated,
          onTap: _openDestination,
        ),
        const SizedBox(height: AppConstants.spaceLg),
        DestinationRail(
          title: 'Recently viewed',
          destinations: provider.recentlyViewed,
          onTap: _openDestination,
        ),
        const SizedBox(height: AppConstants.spaceXl),
      ],
    );
  }
}
