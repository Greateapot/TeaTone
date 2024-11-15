import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/battery_level_sensor/battery_level_sensor.dart';
import 'package:teatone/src/widgets/widgets.dart';

class BatteryLevelPercentage extends StatelessWidget {
  const BatteryLevelPercentage({
    super.key,
    this.style,
    this.blinkOnLowBatteryCharge = true,
  });

  final TextStyle? style;
  final bool blinkOnLowBatteryCharge;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatteryLevelSensorBloc, BatteryLevelSensorState>(
      builder: (context, state) => switch (state) {
        BatteryLevelSensorInitial() => Text('100%', style: style),
        BatteryLevelSensorProcessing() =>
          blinkOnLowBatteryCharge && state.batteryChargePercentage <= 20
              ? BlinkingText(
                  '${state.batteryChargePercentage}%',
                  style: style,
                )
              : Text(
                  '${state.batteryChargePercentage}%',
                  style: style,
                ),
      },
    );
  }
}
