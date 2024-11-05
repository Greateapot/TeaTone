import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/deletor/deletor.dart';
import 'package:teatone/shared/shared.dart';

part 'deletor_processing_view.dart';

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
