import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';

/// The pill-shaped search input with an optional trailing filter button,
/// matching the Home screen's search bar in the design reference.
class SearchField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;
  final bool autofocus;

  const SearchField({
    super.key,
    this.hintText = 'Search',
    this.onChanged,
    this.onFilterTap,
    this.controller,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: autofocus,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search_rounded, size: 22),
            ),
          ),
        ),
        if (onFilterTap != null) ...[
          const SizedBox(width: AppConstants.spaceSm),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkPill : AppColors.lightPill,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.tune_rounded,
                color: isDark ? AppColors.darkPillText : AppColors.lightPillText,
                size: 20,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
