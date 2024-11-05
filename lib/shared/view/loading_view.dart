part of 'view.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Loading...',
        style: textTheme.displaySmall?.copyWith(
          color: colorScheme.primary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
