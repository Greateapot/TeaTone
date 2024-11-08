import 'package:flutter/material.dart';

class PositionIndicator extends StatelessWidget {
  const PositionIndicator({
    super.key,
    this.position,
    this.duration,
    this.minHeight,
  });

  final Duration? position;
  final Duration? duration;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final double value = (duration != null && duration!.inMilliseconds > 0)
        ? ((position?.inMilliseconds ?? 0) / duration!.inMilliseconds)
        : 0;

    return LinearProgressIndicator(
      backgroundColor: colorScheme.primaryContainer,
      color: colorScheme.primary,
      value: value,
      minHeight: minHeight,
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}
