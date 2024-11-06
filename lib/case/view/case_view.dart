import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/battery_level_sensor/battery_level_sensor.dart';
import 'package:teatone/case/case.dart';
import 'package:teatone/deletor/deletor.dart';
import 'package:teatone/player/player.dart';
import 'package:teatone/record_selector/record_selector.dart';
import 'package:teatone/recorder/recorder.dart';

part 'home_view.dart';
part 'done_view.dart';
part 'canceled_view.dart';

class CasePage extends StatelessWidget {
  const CasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CaseBloc>(
          create: (context) => CaseBloc(),
        ),
        BlocProvider<RecorderBloc>(
          create: (context) => RecorderBloc(),
        ),
        BlocProvider<PlayerBloc>(
          create: (context) => PlayerBloc(),
        ),
        BlocProvider<RecordSelectorBloc>(
          create: (context) => RecordSelectorBloc(),
        ),
        BlocProvider<DeletorBloc>(
          create: (context) => DeletorBloc(),
        ),
        BlocProvider<BatteryLevelSensorBloc>(
          create: (context) => BatteryLevelSensorBloc(),
        ),
      ],
      child: const CaseView(),
    );
  }
}

class CaseView extends StatelessWidget {
  const CaseView({super.key});

  @override
  Widget build(BuildContext context) {
    /// Потенциально лютый говнокод
    context.read<CaseBloc>().contextReader = context.read;

    /// Запуск разрядки батареи
    context
        .read<BatteryLevelSensorBloc>()
        .add(const BatteryLevelSensorStarted());

    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: CaseDisplayPanel()),
          CaseButtonPanel(),
        ],
      ),
    );
  }
}
