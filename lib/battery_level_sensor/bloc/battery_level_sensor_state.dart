part of 'battery_level_sensor_bloc.dart';

sealed class BatteryLevelSensorState extends Equatable {
  const BatteryLevelSensorState({
    required this.batteryChargePercentage,
    required this.isDisplayOff,
  });

  final int batteryChargePercentage;
  final bool isDisplayOff;

  @override
  List<Object> get props => [batteryChargePercentage, isDisplayOff];
}

final class BatteryLevelSensorInitial extends BatteryLevelSensorState {
  const BatteryLevelSensorInitial({
    super.batteryChargePercentage = 100,
    super.isDisplayOff = false,
  });
}

final class BatteryLevelSensorProcessing extends BatteryLevelSensorState {
  const BatteryLevelSensorProcessing({
    required super.batteryChargePercentage,
    required super.isDisplayOff,
  });

  BatteryLevelSensorProcessing copyWith({
    int? batteryChargePercentage,
    bool? isDisplayOff,
  }) =>
      BatteryLevelSensorProcessing(
        batteryChargePercentage:
            batteryChargePercentage ?? this.batteryChargePercentage,
        isDisplayOff: isDisplayOff ?? this.isDisplayOff,
      );
}
