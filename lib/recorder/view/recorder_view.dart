import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/recorder/recorder.dart';
import 'package:teatone/shared/shared.dart';

part 'recorder_run_in_progress_view.dart';
part 'recorder_run_pause_view.dart';

class RecorderView extends StatelessWidget {
  const RecorderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderBloc, RecorderState>(
      builder: (context, state) => switch (state) {
        RecorderInitial() => const LoadingView(),
        RecorderRunInProgress() => RecorderInProgressView(state.duration),
        RecorderRunPause() => RecorderPausedView(state.duration),
      },
    );
  }
}
