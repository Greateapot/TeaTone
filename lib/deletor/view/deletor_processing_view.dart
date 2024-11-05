part of 'deletor_view.dart';

class DeletorProcessingView extends StatelessWidget {
  const DeletorProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Are You Sure?',
        style: textTheme.displaySmall?.copyWith(
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
