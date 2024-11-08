import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/display/display.dart';

class Display extends StatelessWidget {
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayBloc, DisplayState>(
      builder: (context, state) => state.isDisplayOff
          ? _displayOffBuilder(context, state)
          : _displayOnBuilder(context, state),
    );
  }

  Widget _displayOffBuilder(BuildContext context, DisplayState state) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: colorScheme.primaryContainer,
          width: 3.0,
        ),
      ),
    );
  }

  Widget _displayOnBuilder(BuildContext context, DisplayState state) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: colorScheme.primaryContainer,
          width: 3.0,
        ),
      ),
      child: SizedBox.expand(
        child: Column(
          children: [
            const DisplayStatusBar(),
            Expanded(child: _bodyBuilder(context, state)),
          ],
        ),
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context, DisplayState state) =>
      switch (state) {
        DisplayHome() => const HomeView(),
        DisplayCanceled() => const CanceledView(),
        DisplayDone() => const DoneView(),
        DisplayRecorder() => const RecorderView(),
        DisplayPlayer() => const PlayerView(),
        DisplayDeletor() => const DeletorView(),
        DisplayRecordSelector() => const RecordSelectorView(),
      };
}
