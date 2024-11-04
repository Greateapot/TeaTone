part of 'recorder_view.dart';

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
