part of 'widgets.dart';

class CaseDisplayStatusBar extends StatelessWidget {
  const CaseDisplayStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // TODO: StatusBar widget (BatteryBloc listener)
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'TeaTone v1',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        Text(
          '?%',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
