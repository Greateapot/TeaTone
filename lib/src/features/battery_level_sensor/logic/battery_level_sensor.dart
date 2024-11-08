import 'dart:async';

class BatteryLevelSensorConfig {
  const BatteryLevelSensorConfig({
    this.batteryCapacity = 600,
    this.batteryDischargeRateWithDisplayOn = 0.1,
    this.batteryDischargeRateWithDisplayOff = 0.05,
    this.lowBatteryChargePercentage = 20,
  });

  /// battery capacity (mAh)
  final double batteryCapacity;

  /// battery discharge rate (with display on; max uptime: 1,6h)
  final double batteryDischargeRateWithDisplayOn;

  /// battery discharge rate (with display off; max uptime: 3,3h)
  final double batteryDischargeRateWithDisplayOff;

  /// block display on if batteryChargePercentage <= lowBatteryChargePercentage
  final int lowBatteryChargePercentage;
}

class BatteryLevelSensor {
  BatteryLevelSensor({
    required BatteryLevelSensorConfig config,
  })  : _config = config,
        _batteryCharge = config.batteryCapacity;

  final BatteryLevelSensorConfig _config;

  double _batteryCharge;
  bool _isDisplayOff = false;

  StreamController<double>? _batteryChargeStreamController;

  Timer? _batteryChargeTimer;
  late Duration _batteryChargeTimerInterval;

  bool? _processing;

  BatteryLevelSensorConfig get config => _config;

  Future<bool> _process() async {
    Future.doWhile(() async {
      _batteryCharge -= _isDisplayOff
          ? _config.batteryDischargeRateWithDisplayOff
          : _config.batteryDischargeRateWithDisplayOn;
      if (_batteryCharge < 0) _batteryCharge = 0;
      await Future.delayed(const Duration(milliseconds: 1000));
      if (_batteryCharge == 0) {
        _processing = false;
        return false;
      }
      return true;
    });

    return true;
  }

  Future<void> turnOffDisplay() async => _isDisplayOff = true;

  Future<void> turnOnDisplay() async => _isDisplayOff = false;

  Future<void> process() async => _processing ??= await _process();

  Future<bool> isBatteryDischarging() async {
    final batteryCharge = _batteryCharge;
    await Future.delayed(const Duration(milliseconds: 1100));
    return _batteryCharge < batteryCharge;
  }

  Future<void> dispose() async {
    _batteryChargeTimer?.cancel();
    _batteryChargeStreamController?.close();
    _batteryChargeStreamController = null;
  }

  /// Recomended interval: 1500 milliseconds
  Stream<double> onBatteryChargeChanged(Duration interval) {
    _batteryChargeStreamController ??= StreamController(
      onCancel: () {
        _batteryChargeTimer?.cancel();
        _batteryChargeStreamController?.close();
        _batteryChargeStreamController = null;
      },
    );

    _batteryChargeTimerInterval = interval;
    _startBatteryChargeTimer();

    return _batteryChargeStreamController!.stream;
  }

  Future<void> _updateBatteryChargeAtInterval() async {
    Future<bool> shouldUpdate() async {
      var result = _batteryChargeStreamController != null;
      result &= !(_batteryChargeStreamController?.isClosed ?? true);
      result &= _batteryChargeStreamController?.hasListener ?? false;
      result &= _batteryChargeTimer?.isActive ?? false;

      return result && await isBatteryDischarging();
    }

    if (await shouldUpdate()) {
      _batteryChargeStreamController?.add(_batteryCharge);
    }
  }

  Future<void> _startBatteryChargeTimer() async {
    _batteryChargeTimer?.cancel();

    if (_batteryChargeStreamController == null) return;

    _batteryChargeTimer = Timer.periodic(
      _batteryChargeTimerInterval,
      (timer) => _updateBatteryChargeAtInterval(),
    );
  }
}
