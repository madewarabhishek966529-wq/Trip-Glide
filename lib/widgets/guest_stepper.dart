import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';

/// Increment/decrement stepper used for the guest counter in the booking
/// flow. Disables its buttons at [min]/[max] rather than letting the
/// provider silently clamp, so the UI reflects the limit.
class GuestStepper extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const GuestStepper({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepperButton(icon: Icons.remove_rounded, onTap: value > min ? onDecrement : null, border: border),
        SizedBox(
          width: 40,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        _StepperButton(icon: Icons.add_rounded, onTap: value < max ? onIncrement : null, border: border),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color border;

  const _StepperButton({required this.icon, required this.onTap, required this.border});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(side: BorderSide(color: border)),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 18, color: enabled ? null : border),
        ),
      ),
    );
  }
}
