part of 'widgets.dart';

class CaseButtonPanel extends StatelessWidget {
  const CaseButtonPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
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
              onPressed: () =>
                  context.read<CaseBloc>().add(const CaseCancelButtonPressed()),
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
              onPressed: () =>
                  context.read<CaseBloc>().add(const CaseRecordButtonPressed()),
              icon: Icons.mic_outlined,
            ),
            CaseButtonData(
              onPressed: () =>
                  context.read<CaseBloc>().add(const CaseRightButtonPressed()),
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
              onPressed: () =>
                  context.read<CaseBloc>().add(const CasePauseButtonPressed()),
              icon: Icons.pause_outlined,
            ),
          ],
        ),
        CaseButtonsRow(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 24.0,
          ),
          caseButtonsData: [
            CaseButtonData(
              onPressed: () =>
                  context.read<CaseBloc>().add(const CaseDeleteButtonPressed()),
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
    );
  }
}
