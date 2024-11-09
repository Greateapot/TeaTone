import 'package:flutter/material.dart';

class DisplayDoneView extends StatelessWidget {
  const DisplayDoneView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Done!',
        style: textTheme.displaySmall?.copyWith(
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
