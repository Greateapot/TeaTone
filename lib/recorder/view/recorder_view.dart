import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/recorder/recorder.dart';
import 'package:teatone/shared/shared.dart';

class RecorderView extends StatelessWidget {
  const RecorderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderBloc, RecorderState>(
      builder: (context, state) => switch (state) {
        RecorderInitial() => const SizedBox.expand(),
        RecorderRunInProgress() => RecorderInProgressView(state.duration),
        RecorderRunPause() => RecorderPausedView(state.duration),
      },
    );
  }
}

class RecorderInProgressView extends StatelessWidget {
  const RecorderInProgressView(this.duration, {super.key});

  final int duration;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Recording In Progress',
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Divider(
          height: 16.0,
          thickness: 3.0,
          indent: 80.0,
          endIndent: 80.0,
          color: colorScheme.primary,
        ),
        TimerWidget(
          duration: duration,
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class RecorderPausedView extends StatelessWidget {
  const RecorderPausedView(this.duration, {super.key});

  final int duration;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Recording Paused',
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Divider(
          height: 16.0,
          thickness: 3.0,
          indent: 80.0,
          endIndent: 80.0,
          color: colorScheme.primary,
        ),
        TimerWidget(
          duration: duration,
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
