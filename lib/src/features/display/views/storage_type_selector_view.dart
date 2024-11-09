import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/storage_type_selector/storage_type_selector.dart';

import 'loading_view.dart';

class StorageTypeSelectorView extends StatelessWidget {
  const StorageTypeSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageTypeSelectorBloc, StorageTypeSelectorState>(
      builder: (context, state) => switch (state) {
        StorageTypeSelectorInitial() => const LoadingView(),
        StorageTypeSelectorProcessing() =>
          const StorageTypeSelectorProcessingView(),
      },
    );
  }
}
