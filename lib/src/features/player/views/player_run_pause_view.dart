import 'package:flutter/material.dart';
import 'package:teatone/src/features/player/player.dart';
import 'package:teatone/src/widgets/widgets.dart';

class PlayerRunPauseView extends StatelessWidget {
  const PlayerRunPauseView({
    super.key,
    this.duration,
    this.position,
    required this.title,
  });

  final String title;

  final Duration? duration;
  final Duration? position;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Playing Paused',
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Title: $title',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 80.0,
            right: 80.0,
            top: 10.0,
            bottom: 3.0,
          ),
          child: PositionIndicator(
            minHeight: 3.0,
            position: position,
            duration: duration,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerWidget(
              duration: position?.inSeconds ?? 0,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
              ),
              blinking: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.remove_outlined,
                color: colorScheme.primary,
              ),
            ),
            TimerWidget(
              duration: duration?.inSeconds ?? 0,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
