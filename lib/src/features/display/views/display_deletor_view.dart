import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/deletor/deletor.dart';

import 'display_loading_view.dart';

class DisplayDeletorView extends StatelessWidget {
  const DisplayDeletorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeletorBloc, DeletorState>(
      builder: (context, state) => switch (state) {
        DeletorInitial() => const DisplayLoadingView(),
        DeletorProcessing() => const DeletorProcessingView(),
      },
    );
  }
}
