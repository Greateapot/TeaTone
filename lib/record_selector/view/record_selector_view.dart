import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/record_selector/record_selector.dart';

class RecordSelectorView extends StatelessWidget {
  const RecordSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordSelectorBloc, RecordSelectorState>(
      builder: (context, state) => const Placeholder(),
    );
  }
}
