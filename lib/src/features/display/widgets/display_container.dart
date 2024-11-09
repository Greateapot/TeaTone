import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/display/display.dart';

class DisplayContainer extends StatelessWidget {
  const DisplayContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocSelector<DisplayBloc, DisplayState, bool>(
      selector: (state) => state.isDisplayOff,
      builder: (context, state) => Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: state ? Colors.black : null,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: colorScheme.primaryContainer,
            width: 3.0,
          ),
        ),
        child: state
            ? null
            : SizedBox.expand(
                child: Column(
                  children: [
                    const DisplayStatusBar(),
                    Expanded(child: child),
                  ],
                ),
              ),
      ),
    );
  }
}
