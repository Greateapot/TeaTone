import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/case/case.dart';
import 'package:teatone/recorder/recorder.dart';

class CaseView extends StatelessWidget {
  const CaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    /// Потенциально лютый говнокод
    context.read<CaseBloc>().contextReader = context.read;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: BlocBuilder<CaseBloc, CaseState>(
                builder: (context, state) => switch (state) {
                  CaseInitial() => const Placeholder(),
                  CaseRecorderRunInProgress() => const RecorderView(),
                  CaseRecorderRunPause() => const RecorderView(),
                },
              ),
            ),
          ),
          CaseButtonsRow(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 16.0,
            ),
            caseButtonsData: [
              CaseButtonData(
                onPressed: () => context
                    .read<CaseBloc>()
                    .add(const CaseConfirmButtonPressed()),
                icon: Icons.check_outlined,
                color: colorScheme.onPrimary,
                backgroundColor: Colors.green,
              ),
              CaseButtonData(
                onPressed: () =>
                    context.read<CaseBloc>().add(const CaseUpButtonPressed()),
                icon: Icons.keyboard_arrow_up_outlined,
                color: colorScheme.onSecondary,
                backgroundColor: colorScheme.secondary,
              ),
              CaseButtonData(
                onPressed: () => context
                    .read<CaseBloc>()
                    .add(const CaseCancelButtonPressed()),
                icon: Icons.close_outlined,
                color: colorScheme.onPrimary,
                backgroundColor: Colors.red,
              ),
            ],
          ),
          CaseButtonsRow(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 16.0,
            ),
            caseButtonsData: [
              CaseButtonData(
                onPressed: () =>
                    context.read<CaseBloc>().add(const CaseLeftButtonPressed()),
                icon: Icons.keyboard_arrow_left_outlined,
                color: colorScheme.onSecondary,
                backgroundColor: colorScheme.secondary,
              ),
              CaseButtonData(
                onPressed: () => context
                    .read<CaseBloc>()
                    .add(const CaseRecordButtonPressed()),
                onLongPress: () {},
                icon: Icons.mic_outlined,
              ),
              CaseButtonData(
                onPressed: () => context
                    .read<CaseBloc>()
                    .add(const CaseRightButtonPressed()),
                icon: Icons.keyboard_arrow_right_outlined,
                color: colorScheme.onSecondary,
                backgroundColor: colorScheme.secondary,
              ),
            ],
          ),
          CaseButtonsRow(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 16.0,
            ),
            caseButtonsData: [
              CaseButtonData(
                onPressed: () =>
                    context.read<CaseBloc>().add(const CasePlayButtonPressed()),
                icon: Icons.play_arrow_outlined,
              ),
              CaseButtonData(
                onPressed: () =>
                    context.read<CaseBloc>().add(const CaseDownButtonPressed()),
                icon: Icons.keyboard_arrow_down_outlined,
                color: colorScheme.onSecondary,
                backgroundColor: colorScheme.secondary,
              ),
              CaseButtonData(
                onPressed: () => context
                    .read<CaseBloc>()
                    .add(const CasePauseButtonPressed()),
                icon: Icons.pause_outlined,
              ),
            ],
          ),
          CaseButtonsRow(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 16.0,
            ),
            caseButtonsData: [
              CaseButtonData(
                onPressed: () => context
                    .read<CaseBloc>()
                    .add(const CaseDeleteButtonPressed()),
                icon: Icons.delete_outlined,
                color: colorScheme.onTertiary,
                backgroundColor: colorScheme.tertiary,
              ),
              CaseButtonData(
                onPressed: () =>
                    context.read<CaseBloc>().add(const CaseStopButtonPressed()),
                icon: Icons.stop_outlined,
              ),
              CaseButtonData(
                onPressed: () => context
                    .read<CaseBloc>()
                    .add(const CaseSettingsButtonPressed()),
                icon: Icons.settings_outlined,
                color: colorScheme.onTertiary,
                backgroundColor: colorScheme.tertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}