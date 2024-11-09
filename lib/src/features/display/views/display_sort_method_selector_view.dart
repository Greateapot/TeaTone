import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/sort_method_selector/sort_method_selector.dart';

import 'display_loading_view.dart';

class DisplaySortMethodSelectorView extends StatelessWidget {
  const DisplaySortMethodSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortMethodSelectorBloc, SortMethodSelectorState>(
      builder: (context, state) => switch (state) {
        SortMethodSelectorInitial() => const DisplayLoadingView(),
        SortMethodSelectorProcessing() =>
          const SortMethodSelectorProcessingView(),
      },
    );
  }
}
