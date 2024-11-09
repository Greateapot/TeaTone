import 'package:flutter/material.dart';

class DisplayCanceledView extends StatelessWidget {
  const DisplayCanceledView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Canceled.',
        style: textTheme.displaySmall?.copyWith(
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
