import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/storage_type_selector/storage_type_selector.dart';

class StorageTypeSelectorProcessingView extends StatefulWidget {
  const StorageTypeSelectorProcessingView({super.key});

  @override
  State<StorageTypeSelectorProcessingView> createState() =>
      _StorageTypeSelectorProcessingViewState();
}

class _StorageTypeSelectorProcessingViewState
    extends State<StorageTypeSelectorProcessingView> {
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
          'Select storage type',
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
          child:
              BlocConsumer<StorageTypeSelectorBloc, StorageTypeSelectorState>(
            listener: (context, state) async {
              /// May accidentally intercept the [StorageTypeSelectorInitial] state
              if (state is! StorageTypeSelectorProcessing) return;

              await _scrollController.position.animateTo(
                (_scrollController.position.viewportDimension +
                        _scrollController.position.maxScrollExtent) *
                    (state.selectedIndex - 2) /
                    state.storageTypes.length,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            builder: (context, state) {
              if (state is! StorageTypeSelectorProcessing) {
                dev.log('(StorageTypeSelectorProcessingView.builder) '
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
                  itemCount: state.storageTypes.length,
                  itemBuilder: (context, index) {
                    final record = state.storageTypes[index];

                    return ListTile(
                      title: Text(
                        record.name,
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
}
