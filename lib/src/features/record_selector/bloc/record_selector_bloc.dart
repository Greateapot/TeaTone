import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teatone/src/features/storage/storage.dart';

part 'record_selector_event.dart';
part 'record_selector_state.dart';

class RecordSelectorBloc
    extends Bloc<RecordSelectorEvent, RecordSelectorState> {
  RecordSelectorBloc(this.storageRepository)
      : super(const RecordSelectorInitial()) {
    on<RecordSelectorStarted>(_onStarted);
    on<RecordSelectorPreviousSelected>(_onPreviousSelected);
    on<RecordSelectorNextSelected>(_onNextSelected);
    on<RecordSelectorSelectingCanceled>(_onSelectingCanceled);
    on<RecordSelectorSelectingCompleted>(_onSelectingCompleted);
  }

  final StorageRepository storageRepository;

  void _onStarted(
    RecordSelectorStarted event,
    Emitter<RecordSelectorState> emit,
  ) {
    try {
      if (state is! RecordSelectorInitial) return;

      /// get it from storage
      final List<dynamic> records = [];

      if (records.isEmpty) {
        emit(const RecordSelectorStorageIsEmpty());
      } else {
        emit(RecordSelectorProcessing(records: records, selectedIndex: 0));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecordSelectorBloc._onStarted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onPreviousSelected(
    RecordSelectorPreviousSelected event,
    Emitter<RecordSelectorState> emit,
  ) {
    try {
      final currentState = state;
      if (currentState is! RecordSelectorProcessing) return;

      if (currentState.selectedIndex > 0) {
        emit(currentState.copyWith(currentState.selectedIndex - 1));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecordSelectorBloc._onPreviousSelected",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onNextSelected(
    RecordSelectorNextSelected event,
    Emitter<RecordSelectorState> emit,
  ) {
    try {
      final currentState = state;
      if (currentState is! RecordSelectorProcessing) return;

      if (currentState.selectedIndex < currentState.records.length - 1) {
        emit(currentState.copyWith(currentState.selectedIndex + 1));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecordSelectorBloc._onNextSelected",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onSelectingCanceled(
    RecordSelectorSelectingCanceled event,
    Emitter<RecordSelectorState> emit,
  ) {
    try {
      if (state is! RecordSelectorProcessing &&
          state is! RecordSelectorStorageIsEmpty) return;

      emit(const RecordSelectorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecordSelectorBloc._onSelectingCanceled",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onSelectingCompleted(
    RecordSelectorSelectingCompleted event,
    Emitter<RecordSelectorState> emit,
  ) {
    try {
      final currentState = state;
      if (currentState is! RecordSelectorProcessing) return;

      if (event.callback != null) {
        event.callback!(currentState.records[currentState.selectedIndex]);
      }

      emit(const RecordSelectorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecordSelectorBloc._onSelectingCompleted",
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
