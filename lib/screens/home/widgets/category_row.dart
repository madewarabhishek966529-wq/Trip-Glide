import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import '../../../models/category.dart';
import '../../../widgets/category_chip.dart';

/// "Select your next trip" heading + horizontal scrolling category chips.
class CategoryRow extends StatelessWidget {
  final List<Category> categories;
  final String selectedId;
  final ValueChanged<String> onSelect;

  const CategoryRow({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
          child: Text('Select your next trip', style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        SizedBox(
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
                selected: category.id == selectedId,
                onTap: () => onSelect(category.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
