import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/recorder/recorder.dart';

import 'loading_view.dart';

class RecorderView extends StatelessWidget {
  const RecorderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderBloc, RecorderState>(
      builder: (context, state) => switch (state) {
        RecorderInitial() => const LoadingView(),
        RecorderRunInProgress() =>
          RecorderInProgressView(duration: state.duration),
        RecorderRunPause() => RecorderPausedView(duration: state.duration),
      },
    );
  }
}
