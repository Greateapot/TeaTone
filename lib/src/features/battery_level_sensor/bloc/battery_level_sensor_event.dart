part of 'battery_level_sensor_bloc.dart';

sealed class BatteryLevelSensorEvent extends Equatable {
  const BatteryLevelSensorEvent();

  @override
  List<Object> get props => [];
}

final class BatteryLevelSensorStarted extends BatteryLevelSensorEvent {
  const BatteryLevelSensorStarted([this.onLowBatteryChargePercentage]);

  final void Function()? onLowBatteryChargePercentage;
}

final class BatteryLevelSensorDisplayStateChanged
    extends BatteryLevelSensorEvent {
  const BatteryLevelSensorDisplayStateChanged();
}

// final class BatteryLevelSensorDisplayOff extends BatteryLevelSensorEvent {
//   const BatteryLevelSensorDisplayOff();
// }

// final class BatteryLevelSensorDisplayOn extends BatteryLevelSensorEvent {
//   const BatteryLevelSensorDisplayOn();
// }

final class _BatteryLevelSensorDischarging extends BatteryLevelSensorEvent {
  const _BatteryLevelSensorDischarging(this.batteryChargePercentage);

  final int batteryChargePercentage;
}
