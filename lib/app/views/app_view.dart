import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/battery_level_sensor/battery_level_sensor.dart';
import 'package:teatone/src/features/deletor/deletor.dart';
import 'package:teatone/src/features/parameters/parameters.dart';
import 'package:teatone/src/features/player/player.dart';
import 'package:teatone/src/features/record_selector/record_selector.dart';
import 'package:teatone/src/features/recorder/recorder.dart';
import 'package:teatone/src/features/storage/storage.dart';
import 'package:teatone/src/features/display/display.dart';
import 'package:teatone/app/app.dart' show CaseButtonPanel;

class App extends StatelessWidget {
  static const String title = "TeaTone";

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App.title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _randomColor()),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => const StorageRepository(),
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

  @override
  Widget build(BuildContext context) {
    final StorageRepository storageRepository =
        context.read<StorageRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => DisplayBloc(),
        ),
        BlocProvider<ParametersBloc>(
          lazy: false,
          create: (context) =>
              ParametersBloc(storageRepository)..add(const ParametersLoad()),
        ),
        BlocProvider<RecorderBloc>(
          create: (context) => RecorderBloc(storageRepository),
        ),
        BlocProvider<PlayerBloc>(
          create: (context) => PlayerBloc(storageRepository),
        ),
        BlocProvider<RecordSelectorBloc>(
          create: (context) => RecordSelectorBloc(storageRepository),
        ),
        BlocProvider<DeletorBloc>(
          create: (context) => DeletorBloc(storageRepository),
        ),
        BlocProvider<BatteryLevelSensorBloc>(
          create: (context) =>
              BatteryLevelSensorBloc()..add(const BatteryLevelSensorStarted()),
        ),
      ],
      child: const Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Display(),
              ),
            ),
            CaseButtonPanel(),
          ],
        ),
      ),
    );
  }
}
