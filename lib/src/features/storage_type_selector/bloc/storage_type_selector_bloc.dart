import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teatone/src/features/storage/storage.dart';

part 'storage_type_selector_event.dart';
part 'storage_type_selector_state.dart';

class StorageTypeSelectorBloc
    extends Bloc<StorageTypeSelectorEvent, StorageTypeSelectorState> {
  StorageTypeSelectorBloc(this.storageRepository)
      : super(const StorageTypeSelectorInitial()) {
    on<StorageTypeSelectorSelectingStarted>(_onSelectingStarted);
    on<StorageTypeSelectorPreviousSelected>(_onPreviousSelected);
    on<StorageTypeSelectorNextSelected>(_onNextSelected);
    on<StorageTypeSelectorSelectingCanceled>(_onSelectingCanceled);
    on<StorageTypeSelectorSelectingCompleted>(_onSelectingCompleted);
  }

  final StorageRepository storageRepository;

  void _onSelectingStarted(
    StorageTypeSelectorSelectingStarted event,
    Emitter<StorageTypeSelectorState> emit,
  ) async {
    try {
      if (state is! StorageTypeSelectorInitial) return;

      final List<StorageType> storageTypes = [StorageType.internal];
      if (await storageRepository.isExternalStorageAvailable()) {
        storageTypes.add(StorageType.external);
      }

      // if extmem currently selected and unavailable, currentIndex is -1
      final currentIndex = storageTypes.indexOf(event.storageType);

      emit(StorageTypeSelectorProcessing(
        storageTypes: storageTypes,
        currentIndex: currentIndex < 0 ? 0 : currentIndex, // reset to intmem
        selectedIndex: 0,
      ));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in StorageTypeSelectorBloc._onSelectingStarted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onPreviousSelected(
    StorageTypeSelectorPreviousSelected event,
    Emitter<StorageTypeSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! StorageTypeSelectorProcessing) return;

      if (currentState.selectedIndex > 0) {
        emit(currentState.copyWith(currentState.selectedIndex - 1));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in StorageTypeSelectorBloc._onPreviousSelected",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onNextSelected(
    StorageTypeSelectorNextSelected event,
    Emitter<StorageTypeSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! StorageTypeSelectorProcessing) return;

      if (currentState.selectedIndex < currentState.storageTypes.length - 1) {
        emit(currentState.copyWith(currentState.selectedIndex + 1));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in StorageTypeSelectorBloc._onNextSelected",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onSelectingCanceled(
    StorageTypeSelectorSelectingCanceled event,
    Emitter<StorageTypeSelectorState> emit,
  ) async {
    try {
      if (state is! StorageTypeSelectorProcessing) return;

      emit(const StorageTypeSelectorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in StorageTypeSelectorBloc._onSelectingCanceled",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onSelectingCompleted(
    StorageTypeSelectorSelectingCompleted event,
    Emitter<StorageTypeSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! StorageTypeSelectorProcessing) return;

      if (event.callback != null) {
        event.callback!(currentState.storageTypes[currentState.selectedIndex]);
      }

      emit(const StorageTypeSelectorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in StorageTypeSelectorBloc._onSelectingCompleted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _log(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      dev.log(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
