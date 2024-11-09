import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/sort_method_selector/sort_method_selector.dart';

import 'loading_view.dart';

class SortMethodSelectorView extends StatelessWidget {
  const SortMethodSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortMethodSelectorBloc, SortMethodSelectorState>(
      builder: (context, state) => switch (state) {
        SortMethodSelectorInitial() => const LoadingView(),
        SortMethodSelectorProcessing() =>
          const SortMethodSelectorProcessingView(),
      },
    );
  }
}
