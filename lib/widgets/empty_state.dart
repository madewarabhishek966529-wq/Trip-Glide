import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import 'app_button.dart';

/// Generic empty-state visual: icon, title, subtitle, optional action.
/// Reused for empty search results, empty favorites, empty booking
/// history, and empty recently-viewed.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spaceXl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
          ),
          const SizedBox(height: AppConstants.spaceLg),
          Text(title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(height: AppConstants.spaceSm),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: AppConstants.spaceLg),
            SizedBox(width: 200, child: PrimaryButton(label: actionLabel!, onPressed: onAction)),
          ],
        ],
      ),
    );
  }
}
