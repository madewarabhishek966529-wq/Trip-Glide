import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../models/destination.dart';
import '../../providers/destination_provider.dart';
import '../../providers/search_provider.dart';
import '../../repositories/category_repository.dart';
import '../../routes/app_routes.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/destination_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/search_field.dart';

/// Search & filter screen: instant (debounced) search plus category,
/// country, and minimum-rating filters, shown as a results grid.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final CategoryRepository _categoryRepo = CategoryRepository();
  final TextEditingController _controller = TextEditingController();
  bool _filtersOpen = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDestination(Destination destination) {
    context.read<DestinationProvider>().recordView(destination.id);
    Navigator.of(context).pushNamed(AppRoutes.details, arguments: destination.id);
  }

  @override
  Widget build(BuildContext context) {
    final search = context.watch<SearchProvider>();
    final categories = _categoryRepo.getAll();

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
              child: SearchField(
                hintText: 'City, country, or vibe (beach, hiking...)',
                controller: _controller,
                onChanged: search.updateQuery,
                onFilterTap: () => setState(() => _filtersOpen = !_filtersOpen),
                autofocus: false,
              ),
            ),
            if (_filtersOpen) ...[
              const SizedBox(height: AppConstants.spaceMd),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppConstants.spaceSm),
                  itemBuilder: (context, i) {
                    final c = categories[i];
                    return CategoryChip(
                      label: c.name,
                      selected: search.categoryId == c.id,
                      onTap: () => search.setCategory(search.categoryId == c.id ? null : c.id),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: search.country,
                        isExpanded: true,
                        hint: const Text('Country'),
                        items: search.availableCountries
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: search.setCountry,
                      ),
                    ),
                    const SizedBox(width: AppConstants.spaceSm),
                    Expanded(
                      child: DropdownButtonFormField<double>(
                        value: search.minRating,
                        isExpanded: true,
                        hint: const Text('Min rating'),
                        items: const [4.0, 4.5, 4.8]
                            .map((r) => DropdownMenuItem(value: r, child: Text('$r+')))
                            .toList(),
                        onChanged: search.setMinRating,
                      ),
                    ),
                  ],
                ),
              ),
              if (search.hasActiveFilters)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: search.clearFilters, child: const Text('Clear filters')),
                ),
            ],
            const SizedBox(height: AppConstants.spaceSm),
            Expanded(child: _buildResults(search)),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(SearchProvider search) {
    if (!search.hasSearched) {
      return const EmptyState(
        icon: Icons.travel_explore_rounded,
        title: 'Find your next trip',
        message: 'Search by city, country, or try a category filter above.',
      );
    }

    if (search.results.isEmpty) {
      return EmptyState(
        icon: Icons.search_off_rounded,
        title: 'No destinations found',
        message: 'Try a different search term or clear your filters.',
        actionLabel: search.hasActiveFilters ? 'Clear filters' : null,
        onAction: search.hasActiveFilters ? search.clearFilters : null,
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.spaceLg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppConstants.spaceMd,
        crossAxisSpacing: AppConstants.spaceMd,
        childAspectRatio: 0.72,
      ),
      itemCount: search.results.length,
      itemBuilder: (context, index) {
        final destination = search.results[index];
        return DestinationCard(
          destination: destination,
          width: double.infinity,
          height: double.infinity,
          onTap: () => _openDestination(destination),
        );
      },
    );
  }
}
