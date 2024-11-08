import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/record_selector/record_selector.dart';

import 'loading_view.dart';

class RecordSelectorView extends StatelessWidget {
  const RecordSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordSelectorBloc, RecordSelectorState>(
      builder: (context, state) => switch (state) {
        RecordSelectorInitial() => const LoadingView(),
        RecordSelectorProcessing() => const RecordSelectorProcessingView(),
        RecordSelectorStorageIsEmpty() =>
          const RecordSelectorStorageIsEmptyView(),
      },
    );
  }
}
