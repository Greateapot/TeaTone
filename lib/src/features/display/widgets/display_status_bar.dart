import 'package:flutter/material.dart';
import 'package:teatone/src/features/battery_level_sensor/battery_level_sensor.dart';

class DisplayStatusBar extends StatelessWidget {
  const DisplayStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'TeaTone v1',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        BatteryLevelPercentage(
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
