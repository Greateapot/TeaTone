import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teatone/battery_level_sensor/battery_level_sensor.dart';

part 'battery_level_sensor_event.dart';
part 'battery_level_sensor_state.dart';

class BatteryLevelSensorBloc
    extends Bloc<BatteryLevelSensorEvent, BatteryLevelSensorState> {
  BatteryLevelSensorBloc() : super(const BatteryLevelSensorInitial()) {
    _batteryLevelSensor = BatteryLevelSensor(
      config: const BatteryLevelSensorConfig(),
    );

    on<BatteryLevelSensorStarted>(_onStarted);
    on<BatteryLevelSensorDisplayStateChanged>(_onDisplayStateChanged);
    on<_BatteryLevelSensorDischarging>(_onDischarging);
  }

  late final BatteryLevelSensor _batteryLevelSensor;

  StreamSubscription? _batteryChargeStreamSubscription;

  Future<void> _onStarted(
    BatteryLevelSensorStarted event,
    Emitter<BatteryLevelSensorState> emit,
  ) async {
    try {
      if (state is! BatteryLevelSensorInitial) return;

      _batteryChargeStreamSubscription = _batteryLevelSensor
          .onBatteryChargeChanged(const Duration(milliseconds: 1500))
          .listen(
        (batteryCharge) {
          final batteryChargeRatio =
              batteryCharge / _batteryLevelSensor.config.batteryCapacity;
          final batteryChargePercentage = (batteryChargeRatio * 100).round();

          add(_BatteryLevelSensorDischarging(batteryChargePercentage));
        },
      );

      await _batteryLevelSensor.process();

      emit(BatteryLevelSensorProcessing(
        batteryChargePercentage: state.batteryChargePercentage,
        isDisplayOff: state.isDisplayOff,
      ));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in BatteryLevelSensorBloc._onStarted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _onDisplayStateChanged(
    BatteryLevelSensorDisplayStateChanged event,
    Emitter<BatteryLevelSensorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! BatteryLevelSensorProcessing) return;

      if (currentState.isDisplayOff) {
        if (currentState.batteryChargePercentage <=
            _batteryLevelSensor.config.lowBatteryChargePercentage) return;

        await _batteryLevelSensor.turnOnDisplay();

        emit(currentState.copyWith(isDisplayOff: false));
      } else {
        await _batteryLevelSensor.turnOffDisplay();

        emit(currentState.copyWith(isDisplayOff: true));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in BatteryLevelSensorBloc._onDisplayStateChanged",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // Future<void> _onDisplayOn(
  //   BatteryLevelSensorDisplayOn event,
  //   Emitter<BatteryLevelSensorState> emit,
  // ) async {
  //   try {
  //     final currentState = state;
  //     if (currentState is! BatteryLevelSensorProcessing) return;

  //     if (currentState.batteryChargePercentage <=
  //         _batteryLevelSensor.config.lowBatteryChargePercentage) return;

  //     await _batteryLevelSensor.turnOnDisplay();

  //     emit(currentState.copyWith(isDisplayOff: false));
  //   } catch (error, stackTrace) {
  //     _log(
  //       "Encountered an error in BatteryLevelSensorBloc._onDisplayOn",
  //       error: error,
  //       stackTrace: stackTrace,
  //     );
  //   }
  // }

  Future<void> _onDischarging(
    _BatteryLevelSensorDischarging event,
    Emitter<BatteryLevelSensorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! BatteryLevelSensorProcessing) return;

      emit(currentState.copyWith(
        batteryChargePercentage: event.batteryChargePercentage,
        isDisplayOff: currentState.batteryChargePercentage <=
                _batteryLevelSensor.config.lowBatteryChargePercentage
            ? true
            : null,
      ));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in BatteryLevelSensorBloc._onDischarging",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _log(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      dev.log(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> close() async {
    await _batteryLevelSensor.dispose();
    await _batteryChargeStreamSubscription?.cancel();
    return super.close();
  }
}
