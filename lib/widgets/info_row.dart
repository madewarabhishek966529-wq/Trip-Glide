import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';

/// Icon + label + value row used in the destination detail "Travel
/// information" panel and booking summary.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
          const SizedBox(width: AppConstants.spaceSm),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          Text(value, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
