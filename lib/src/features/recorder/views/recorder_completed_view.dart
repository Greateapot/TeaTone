import 'package:flutter/material.dart';
import 'package:teatone/src/widgets/widgets.dart';

class RecorderCompletedView extends StatelessWidget {
  const RecorderCompletedView({
    super.key,
    required this.title,
    required this.duration,
  });

  final String title;
  final int duration;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Recording Completed!',
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
        Text(
          'Title: $title',
          style: textTheme.titleLarge?.copyWith(
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
        Text(
          'Duration:',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        TimerWidget(
          duration: duration,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
