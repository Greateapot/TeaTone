import 'package:flutter/material.dart';

import 'blinking_text.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
    required this.duration,
    this.style,
    this.blinking = false,
  });

  final int duration;
  final TextStyle? style;
  final bool blinking;

  @override
  Widget build(BuildContext context) {
    final String minutes = _formatNumber(duration ~/ 60);
    final String seconds = _formatNumber(duration % 60);

    return blinking
        ? BlinkingText('$minutes : $seconds', style: style)
        : Text('$minutes : $seconds', style: style);
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) numberStr = '0$numberStr';
    return numberStr;
  }
}
