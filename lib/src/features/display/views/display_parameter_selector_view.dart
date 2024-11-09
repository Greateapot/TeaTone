import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/parameter_selector/parameter_selector.dart';

import 'display_loading_view.dart';

class DisplayParameterSelectorView extends StatelessWidget {
  const DisplayParameterSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParameterSelectorBloc, ParameterSelectorState>(
      builder: (context, state) => switch (state) {
        ParameterSelectorInitial() => const DisplayLoadingView(),
        ParameterSelectorProcessing() =>
          const ParameterSelectorProcessingView(),
      },
    );
  }
}
