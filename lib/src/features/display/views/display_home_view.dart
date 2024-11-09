import 'package:flutter/material.dart';

class DisplayHomeView extends StatelessWidget {
  const DisplayHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Welcome!',
        style: textTheme.displaySmall?.copyWith(
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
