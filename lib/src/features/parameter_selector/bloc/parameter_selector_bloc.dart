import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'parameter_selector_event.dart';
part 'parameter_selector_state.dart';

class ParameterSelectorBloc
    extends Bloc<ParameterSelectorEvent, ParameterSelectorState> {
  ParameterSelectorBloc() : super(const ParameterSelectorInitial()) {
    on<ParameterSelectorSelectingStarted>(_onSelectingStarted);
    on<ParameterSelectorPreviousSelected>(_onPreviousSelected);
    on<ParameterSelectorNextSelected>(_onNextSelected);
    on<ParameterSelectorSelectingCanceled>(_onSelectingCanceled);
    on<ParameterSelectorSelectingCompleted>(_onSelectingCompleted);
  }

  void _onSelectingStarted(
    ParameterSelectorSelectingStarted event,
    Emitter<ParameterSelectorState> emit,
  ) async {
    try {
      if (state is! ParameterSelectorInitial) return;

      emit(const ParameterSelectorProcessing(
        parameters: Parameter.values,
        selectedIndex: 0,
      ));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in ParameterSelectorBloc._onSelectingStarted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onPreviousSelected(
    ParameterSelectorPreviousSelected event,
    Emitter<ParameterSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! ParameterSelectorProcessing) return;

      if (currentState.selectedIndex > 0) {
        emit(currentState.copyWith(currentState.selectedIndex - 1));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in ParameterSelectorBloc._onPreviousSelected",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onNextSelected(
    ParameterSelectorNextSelected event,
    Emitter<ParameterSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! ParameterSelectorProcessing) return;

      if (currentState.selectedIndex < currentState.parameters.length - 1) {
        emit(currentState.copyWith(currentState.selectedIndex + 1));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in ParameterSelectorBloc._onNextSelected",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onSelectingCanceled(
    ParameterSelectorSelectingCanceled event,
    Emitter<ParameterSelectorState> emit,
  ) async {
    try {
      if (state is! ParameterSelectorProcessing) return;

      emit(const ParameterSelectorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in ParameterSelectorBloc._onSelectingCanceled",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onSelectingCompleted(
    ParameterSelectorSelectingCompleted event,
    Emitter<ParameterSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! ParameterSelectorProcessing) return;

      if (event.callback != null) {
        event.callback!(currentState.parameters[currentState.selectedIndex]);
      }

      emit(const ParameterSelectorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in ParameterSelectorBloc._onSelectingCompleted",
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
