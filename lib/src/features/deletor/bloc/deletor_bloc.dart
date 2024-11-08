import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teatone/src/features/storage/storage.dart';

part 'deletor_event.dart';
part 'deletor_state.dart';

class DeletorBloc extends Bloc<DeletorEvent, DeletorState> {
  DeletorBloc(this.storageRepository) : super(const DeletorInitial()) {
    on<DeletorStarted>(_onStarted);
    on<DeletorConfirmed>(_onConfirmed);
    on<DeletorCanceled>(_onCanceled);
  }

  final StorageRepository storageRepository;

  void _onStarted(
    DeletorStarted event,
    Emitter<DeletorState> emit,
  ) {
    try {
      if (state is! DeletorInitial) return;

      emit(DeletorProcessing(event.record));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in DeletorBloc._onStarted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onConfirmed(
    DeletorConfirmed event,
    Emitter<DeletorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! DeletorProcessing) return;

      final result = await storageRepository.deleteRecord(currentState.record);

      if (event.onSuccess != null && result) event.onSuccess!();
      if (event.onFailure != null && !result) event.onFailure!();

      emit(const DeletorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in DeletorBloc._onConfirmed",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onCanceled(
    DeletorCanceled event,
    Emitter<DeletorState> emit,
  ) {
    try {
      if (state is! DeletorProcessing) return;

      emit(const DeletorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in DeletorBloc._onCanceled",
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
