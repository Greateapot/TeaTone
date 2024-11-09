import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/sort_method_selector/sort_method_selector.dart';
import 'package:teatone/src/features/storage/storage.dart';

class SortMethodSelectorProcessingView extends StatefulWidget {
  const SortMethodSelectorProcessingView({super.key});

  @override
  State<SortMethodSelectorProcessingView> createState() =>
      _SortMethodSelectorProcessingViewState();
}

class _SortMethodSelectorProcessingViewState
    extends State<SortMethodSelectorProcessingView> {
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
          'Select sort method',
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        Divider(
          height: 16.0,
          thickness: 3.0,
          indent: 40.0,
          endIndent: 40.0,
          color: colorScheme.primary,
        ),
        Expanded(
          child: BlocConsumer<SortMethodSelectorBloc, SortMethodSelectorState>(
            listener: (context, state) async {
              /// May accidentally intercept the [SortMethodSelectorInitial] state
              if (state is! SortMethodSelectorProcessing) return;

              await _scrollController.position.animateTo(
                (_scrollController.position.viewportDimension +
                        _scrollController.position.maxScrollExtent) *
                    (state.selectedIndex - 2) /
                    state.sortMethods.length,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            builder: (context, state) {
              if (state is! SortMethodSelectorProcessing) {
                dev.log('(SortMethodSelectorProcessingView.builder) '
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
                  itemCount: state.sortMethods.length,
                  itemBuilder: (context, index) {
                    final sortMethod = state.sortMethods[index];

                    return ListTile(
                      title: Text(
                        _sortMethodToString(sortMethod),
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      trailing: index == state.selectedIndex
                          ? Icon(
                              Icons.arrow_back_outlined,
                              color: colorScheme.primary,
                            )
                          : index == state.currentIndex
                              ? const Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.green,
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

  String _sortMethodToString(SortMethod sortMethod) => switch (sortMethod) {
        SortMethod.az => 'A-Z',
        SortMethod.za => 'Z-A',
        SortMethod.dt => 'Creation date asc',
        SortMethod.td => 'Creation date desc',
      };
}
