import 'package:flutter/material.dart';

class FailedView extends StatelessWidget {
  const FailedView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Failed.',
        style: textTheme.displaySmall?.copyWith(
          color: colorScheme.error,
        ),
      ),
    );
  }
}