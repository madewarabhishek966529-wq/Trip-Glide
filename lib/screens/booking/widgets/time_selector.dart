import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';

/// Fixed set of tour departure times. A real backend would return
/// availability per date; without one, every slot is always offered.
const List<String> kAvailableTimeSlots = [
  '8:00 AM',
  '10:00 AM',
  '12:00 PM',
  '2:00 PM',
  '4:00 PM',
];

class TimeSelector extends StatelessWidget {
  final String selectedTime;
  final ValueChanged<String> onTimeSelected;

  const TimeSelector({super.key, required this.selectedTime, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select time', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppConstants.spaceSm),
        Wrap(
          spacing: AppConstants.spaceSm,
          runSpacing: AppConstants.spaceSm,
          children: kAvailableTimeSlots.map((time) {
            final isSelected = time == selectedTime;
            return _TimeChip(
              label: time,
              isSelected: isSelected,
              onTap: () => onTimeSelected(time),
            );
          }).toList(growable: false),
        ),
      ],
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeChip({required this.label, required this.isSelected, required this.onTap});

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
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? selectedFg : unselectedFg,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
