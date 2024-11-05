part of 'record_selector_view.dart';

class RecordSelectorStorageIsEmptyView extends StatelessWidget {
  const RecordSelectorStorageIsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Storage Is Empty',
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
