import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/recorder/recorder.dart';

class RecorderView extends StatelessWidget {
  const RecorderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderBloc, RecorderState>(
      builder: (context, state) => switch (state) {
        RecorderInitial() => const Placeholder(),
        RecorderRunInProgress() => _buildTimer(
            context,
            state.duration,
            pause: false,
          ),
        RecorderRunPause() => _buildTimer(
            context,
            state.duration,
            pause: true,
          ),
      },
    );
  }

  Widget _buildTimer(
    BuildContext context,
    int duration, {
    bool pause = false,
  }) {
    const TextStyle style = TextStyle(color: Colors.red);

    final String minutes = _formatNumber(duration ~/ 60);
    final String seconds = _formatNumber(duration % 60);

    final Widget child = pause
        ? BlinkingText('$minutes : $seconds', style: style)
        : Text('$minutes : $seconds', style: style);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [child],
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) numberStr = '0$numberStr';
    return numberStr;
  }
}
