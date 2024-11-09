import 'package:flutter/material.dart';

class DisplayLoadingView extends StatelessWidget {
  const DisplayLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Loading...',
        style: textTheme.displaySmall?.copyWith(
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
