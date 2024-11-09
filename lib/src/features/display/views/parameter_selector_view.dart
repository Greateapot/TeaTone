import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/parameter_selector/parameter_selector.dart';

import 'loading_view.dart';

class ParameterSelectorView extends StatelessWidget {
  const ParameterSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParameterSelectorBloc, ParameterSelectorState>(
      builder: (context, state) => switch (state) {
        ParameterSelectorInitial() => const LoadingView(),
        ParameterSelectorProcessing() =>
          const ParameterSelectorProcessingView(),
      },
    );
  }
}
