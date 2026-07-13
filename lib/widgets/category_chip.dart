import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';

/// A single selectable filter pill, matching the "Asia / Europe / South
/// America" chips in the design reference.
class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedBg = isDark ? AppColors.darkPill : AppColors.lightPill;
    final selectedFg = isDark ? AppColors.darkPillText : AppColors.lightPillText;
    final unselectedBg = isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;
    final unselectedFg = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.animationFast,
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? selectedFg : unselectedFg,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
