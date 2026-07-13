import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../models/category.dart';
import '../../../providers/destination_provider.dart';
import '../../../widgets/category_chip.dart';

/// Horizontal row of category filter pills ("Asia", "Europe", ...),
/// driving [DestinationProvider.selectedCategoryId]. Categories are static
/// seed data, so they're passed in directly rather than through a
/// dedicated provider.
class CategoryFilterRow extends StatelessWidget {
  final List<Category> categories;

  const CategoryFilterRow({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final destinations = context.watch<DestinationProvider>();

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppConstants.spaceSm),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryChip(
            label: category.name,
            selected: destinations.selectedCategoryId == category.id,
            onTap: () => destinations.selectCategory(category.id),
          );
        },
      ),
    );
  }
}
