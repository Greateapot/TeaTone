import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/display/display.dart';

class DisplayView extends StatelessWidget {
  const DisplayView({super.key});

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
      padding: const EdgeInsets.all(8.0),
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
        DisplayHome() => const DisplayHomeView(),
        DisplayCanceled() => const DisplayCanceledView(),
        DisplayDone() => const DisplayDoneView(),
        DisplayRecorder() => const DisplayRecorderView(),
        DisplayPlayer() => const DisplayPlayerView(),
        DisplayDeletor() => const DisplayDeletorView(),
        DisplayRecordSelector() => const DisplayRecordSelectorView(),
        DisplayFailed() => const DisplayFailedView(),
        DisplayParameterSelector() => const DisplayParameterSelectorView(),
        DisplaySortMethodSelector() => const DisplaySortMethodSelectorView(),
        DisplayStorageTypeSelector() => const DisplayStorageTypeSelectorView(),
      };
}
