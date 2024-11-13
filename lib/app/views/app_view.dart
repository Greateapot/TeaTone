import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/app/app.dart' show CaseButtonPanel;

// features
import 'package:teatone/src/features/battery_level_sensor/battery_level_sensor.dart';
import 'package:teatone/src/features/deletor/deletor.dart';
import 'package:teatone/src/features/parameters/parameters.dart';
import 'package:teatone/src/features/parameter_selector/parameter_selector.dart';
import 'package:teatone/src/features/player/player.dart';
import 'package:teatone/src/features/record_selector/record_selector.dart';
import 'package:teatone/src/features/recorder/recorder.dart';
import 'package:teatone/src/features/sort_method_selector/sort_method_selector.dart';
import 'package:teatone/src/features/storage/storage.dart';
import 'package:teatone/src/features/display/display.dart';
import 'package:teatone/src/features/storage_type_selector/storage_type_selector.dart';

class App extends StatelessWidget {
  static const String title = "TeaTone";

  const App({
    super.key,
    required StorageRepository storageRepository,
  }) : _storageRepository = storageRepository;

  final StorageRepository _storageRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App.title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _randomColor()),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => DisplayBloc(),
          ),
          BlocProvider<ParametersBloc>(
            lazy: false,
            create: (context) => ParametersBloc(_storageRepository),
          ),
          BlocProvider<BatteryLevelSensorBloc>(
            lazy: false,
            create: (context) => BatteryLevelSensorBloc(),
          ),
          BlocProvider<RecorderBloc>(
            create: (context) => RecorderBloc(_storageRepository),
          ),
          BlocProvider<PlayerBloc>(
            create: (context) => PlayerBloc(_storageRepository),
          ),
          BlocProvider<DeletorBloc>(
            create: (context) => DeletorBloc(_storageRepository),
          ),
          BlocProvider<RecordSelectorBloc>(
            create: (context) => RecordSelectorBloc(_storageRepository),
          ),
          BlocProvider<StorageTypeSelectorBloc>(
            create: (context) => StorageTypeSelectorBloc(_storageRepository),
          ),
          BlocProvider<SortMethodSelectorBloc>(
            create: (context) => SortMethodSelectorBloc(),
          ),
          BlocProvider<ParameterSelectorBloc>(
            create: (context) => ParameterSelectorBloc(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }

  Color _randomColor() {
    final Random random = Random.secure();
    final r = random.nextInt(128) + 128;
    final g = random.nextInt(128) + 128;
    final b = random.nextInt(128) + 128;
    final seedColor = Color.fromRGBO(r, g, b, 1);
    return seedColor;
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  void _onLowBatteryChargePercentage(BuildContext context) {
    final displayBloc = context.read<DisplayBloc>();

    if (!displayBloc.state.isDisplayOff) {
      displayBloc.add(const DisplayStateChanged());
      context.read<RecorderBloc>().add(const RecorderStopped());
      context.read<PlayerBloc>().add(const PlayerStopped());
      context.read<DeletorBloc>().add(const DeletorCanceled());
      context
          .read<RecordSelectorBloc>()
          .add(const RecordSelectorSelectingCanceled());
      context
          .read<ParameterSelectorBloc>()
          .add(const ParameterSelectorSelectingCanceled());
      context
          .read<SortMethodSelectorBloc>()
          .add(const SortMethodSelectorSelectingCanceled());
      context
          .read<StorageTypeSelectorBloc>()
          .add(const StorageTypeSelectorSelectingCanceled());
      context
          .read<BatteryLevelSensorBloc>()
          .add(const BatteryLevelSensorDisplayStateChanged());
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<ParametersBloc>().add(const ParametersLoaded());
    context.read<BatteryLevelSensorBloc>().add(BatteryLevelSensorStarted(
          () => _onLowBatteryChargePercentage(context),
        ));

    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: DisplayView(),
            ),
          ),
          CaseButtonPanel(),
        ],
      ),
    );
  }
}
