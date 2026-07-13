import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';

/// Lets the user pick a booking date either from a quick horizontal strip
/// of the next three weeks, or via a full calendar for anything further
/// out — covers the common case fast without hiding the rest.
class DateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelector({super.key, required this.selectedDate, required this.onDateSelected});

  static final _dayFormat = DateFormat('EEE');
  static final _dateFormat = DateFormat('d');
  static final _monthFormat = DateFormat('MMM');

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final quickDates = List.generate(21, (i) => DateTime(today.year, today.month, today.day + i));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select date', style: Theme.of(context).textTheme.titleLarge),
            TextButton.icon(
              onPressed: () => _openCalendar(context),
              icon: const Icon(Icons.calendar_month_outlined, size: 18),
              label: const Text('Calendar'),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spaceSm),
        SizedBox(
          height: 76,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: quickDates.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppConstants.spaceSm),
            itemBuilder: (context, index) {
              final date = quickDates[index];
              final isSelected = selectedDate != null &&
                  selectedDate!.year == date.year &&
                  selectedDate!.month == date.month &&
                  selectedDate!.day == date.day;
              return _DateChip(
                date: date,
                isSelected: isSelected,
                onTap: () => onDateSelected(date),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _openCalendar(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 730)),
    );
    if (picked != null) onDateSelected(picked);
  }
}

class _DateChip extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateChip({required this.date, required this.isSelected, required this.onTap});

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
        width: 56,
        padding: const EdgeInsets.symmetric(vertical: AppConstants.spaceSm),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateSelector._dayFormat.format(date),
              style: TextStyle(color: isSelected ? selectedFg : unselectedFg, fontSize: 11, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              DateSelector._dateFormat.format(date),
              style: TextStyle(color: isSelected ? selectedFg : unselectedFg, fontSize: 17, fontWeight: FontWeight.w700),
            ),
            Text(
              DateSelector._monthFormat.format(date),
              style: TextStyle(color: isSelected ? selectedFg : unselectedFg, fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
