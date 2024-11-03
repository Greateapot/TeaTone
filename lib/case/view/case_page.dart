import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/case/case.dart';
import 'package:teatone/recorder/recorder.dart';

class CasePage extends StatelessWidget {
  const CasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CaseBloc>(
          create: (context) => CaseBloc(),
        ),
        BlocProvider<RecorderBloc>(
          create: (context) => RecorderBloc(),
        ),
      ],
      child: const CaseView(),
    );
  }
}
