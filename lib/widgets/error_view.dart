import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import 'app_button.dart';

/// Full-section error display with a retry action. Used whenever a
/// provider's status is [LoadStatus.error] (e.g. Hive read failure).
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spaceXl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded, size: 40, color: AppColors.error),
          const SizedBox(height: AppConstants.spaceMd),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spaceXs),
          Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: AppConstants.spaceLg),
            SizedBox(width: 160, child: SecondaryButton(label: 'Try again', onPressed: onRetry, icon: Icons.refresh_rounded)),
          ],
        ],
      ),
    );
  }
}

/// Thin dismissible banner shown at the top of a screen when the device
/// has no network connection (network images / weather panel are
/// affected; core Hive-backed data is unaffected).
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.warning.withOpacity(0.15),
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: AppConstants.spaceSm),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, size: 16, color: AppColors.warning),
          const SizedBox(width: AppConstants.spaceSm),
          Expanded(
            child: Text(
              "You're offline — photos and live weather may not load.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
