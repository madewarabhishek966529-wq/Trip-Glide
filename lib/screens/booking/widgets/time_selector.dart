import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';

const List<String> kBookingTimeSlots = [
  '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM',
  '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM',
];

/// Horizontal chip picker for the booking time slot.
class TimeSelector extends StatelessWidget {
  final String selectedTime;
  final ValueChanged<String> onTimeSelected;

  const TimeSelector({super.key, required this.selectedTime, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Time', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppConstants.spaceSm),
        Wrap(
          spacing: AppConstants.spaceSm,
          runSpacing: AppConstants.spaceSm,
          children: kBookingTimeSlots.map((time) {
            final selected = time == selectedTime;
            return GestureDetector(
              onTap: () => onTimeSelected(time),
              child: AnimatedContainer(
                duration: AppConstants.animationFast,
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: 10),
                decoration: BoxDecoration(
                  color: selected
                      ? (isDark ? AppColors.darkPill : AppColors.lightPill)
                      : (isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt),
                  borderRadius: BorderRadius.circular(AppConstants.radiusPill),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: selected
                        ? (isDark ? AppColors.darkPillText : AppColors.lightPillText)
                        : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
