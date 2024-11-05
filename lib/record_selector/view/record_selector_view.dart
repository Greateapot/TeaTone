import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/record_selector/record_selector.dart';
import 'package:teatone/shared/shared.dart';

part 'record_selector_processing_view.dart';
part 'record_selector_storage_is_empty_view.dart';

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
