part of 'widgets.dart';

class CaseDisplayPanel extends StatelessWidget {
  const CaseDisplayPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      child: Container(
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
              const CaseDisplayStatusBar(),
              Expanded(
                child: BlocBuilder<CaseBloc, CaseState>(
                  builder: (context, state) => switch (state) {
                    CaseInitial() => const HomeView(),
                    CaseRecorderRunInProgress() => const RecorderView(),
                    CasePlayerRunInProgress() => const PlayerView(),
                    CaseRecordSelectorRunInProgress() =>
                      const RecordSelectorView(),
                    CaseDeletorRunInProgress() => const DeletorView(),
                    CaseCanceled() => const CanceledView(),
                    CaseDone() => const DoneView(),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
