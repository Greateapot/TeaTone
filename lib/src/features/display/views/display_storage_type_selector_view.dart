import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/storage_type_selector/storage_type_selector.dart';

import 'display_loading_view.dart';

class DisplayStorageTypeSelectorView extends StatelessWidget {
  const DisplayStorageTypeSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageTypeSelectorBloc, StorageTypeSelectorState>(
      builder: (context, state) => switch (state) {
        StorageTypeSelectorInitial() => const DisplayLoadingView(),
        StorageTypeSelectorProcessing() =>
          const StorageTypeSelectorProcessingView(),
      },
    );
  }
}
