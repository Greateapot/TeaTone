import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/deletor/deletor.dart';

import 'loading_view.dart';

class DeletorView extends StatelessWidget {
  const DeletorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeletorBloc, DeletorState>(
      builder: (context, state) => switch (state) {
        DeletorInitial() => const LoadingView(),
        DeletorProcessing() => const DeletorProcessingView(),
      },
    );
  }
}
