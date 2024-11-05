part of 'record_selector_view.dart';

class RecordSelectorProcessingView extends StatefulWidget {
  const RecordSelectorProcessingView({super.key});

  @override
  State<RecordSelectorProcessingView> createState() =>
      _RecordSelectorProcessingViewState();
}

class _RecordSelectorProcessingViewState
    extends State<RecordSelectorProcessingView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Select record',
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Divider(
          height: 16.0,
          thickness: 3.0,
          indent: 40.0,
          endIndent: 40.0,
          color: colorScheme.primary,
        ),
        Expanded(
          child: BlocConsumer<RecordSelectorBloc, RecordSelectorState>(
            listener: (context, state) {
              /// May accidentally intercept the [RecordSelectorInitial] state
              if (state is! RecordSelectorProcessing) return;

              _scrollController.position.animateTo(
                (_scrollController.position.viewportDimension +
                        _scrollController.position.maxScrollExtent) *
                    (state.selectedIndex - 2) /
                    state.records.length,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            builder: (context, state) {
              if (state is! RecordSelectorProcessing) {
                dev.log('(RecordSelectorProcessingView.builder) '
                    'Should never be printed');
                return const SizedBox();
              }

              return ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final record = state.records[index];

                    return ListTile(
                      title: Text(
                        record,
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      trailing: index == state.selectedIndex
                          ? Icon(
                              Icons.arrow_back_outlined,
                              color: colorScheme.primary,
                            )
                          : null,
                    );
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
