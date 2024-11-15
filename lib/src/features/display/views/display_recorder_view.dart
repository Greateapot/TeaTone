import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/recorder/recorder.dart';

import 'display_loading_view.dart';

class DisplayRecorderView extends StatelessWidget {
  const DisplayRecorderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderBloc, RecorderState>(
      builder: (context, state) => switch (state) {
        RecorderInitial() => const DisplayLoadingView(),
        RecorderRunInProgress() =>
          RecorderInProgressView(duration: state.duration),
        RecorderRunPause() => RecorderPausedView(duration: state.duration),
        RecorderCompleted() => RecorderCompletedView(
            duration: state.duration,
            title: state.title!,
          ),
      },
    );
  }
}
