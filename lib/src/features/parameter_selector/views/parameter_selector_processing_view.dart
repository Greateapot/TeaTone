import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/parameter_selector/parameter_selector.dart';

class ParameterSelectorProcessingView extends StatefulWidget {
  const ParameterSelectorProcessingView({super.key});

  @override
  State<ParameterSelectorProcessingView> createState() =>
      _ParameterSelectorProcessingViewState();
}

class _ParameterSelectorProcessingViewState
    extends State<ParameterSelectorProcessingView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Select parameter',
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Divider(
          height: 16.0,
          thickness: 3.0,
          indent: 10.0,
          endIndent: 10.0,
          color: colorScheme.primary,
        ),
        Expanded(
          child: BlocConsumer<ParameterSelectorBloc, ParameterSelectorState>(
            listener: (context, state) async {
              /// May accidentally intercept the [ParameterSelectorInitial] state
              if (state is! ParameterSelectorProcessing) return;

              await _scrollController.position.animateTo(
                (_scrollController.position.viewportDimension +
                        _scrollController.position.maxScrollExtent) *
                    (state.selectedIndex - 2) /
                    state.parameters.length,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            builder: (context, state) {
              if (state is! ParameterSelectorProcessing) {
                dev.log('(ParameterSelectorProcessingView.builder) '
                    'Should never be printed');
                return const SizedBox();
              }

              return ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.parameters.length,
                  itemBuilder: (context, index) {
                    final parameter = state.parameters[index];

                    return ListTile(
                      title: Text(
                        _parameterToString(parameter),
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      trailing: index == state.selectedIndex
                          ? Icon(
                              Icons.arrow_back_outlined,
                              color: colorScheme.primary,
                            )
                          : null,
                    );
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }

  String _parameterToString(Parameter parameter) => switch (parameter) {
        Parameter.sortMethod => "Sort method",
        Parameter.storageType => "Storage type",
      };
}
