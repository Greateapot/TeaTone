import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teatone/src/features/storage/storage.dart';

part 'sort_method_selector_event.dart';
part 'sort_method_selector_state.dart';

class SortMethodSelectorBloc
    extends Bloc<SortMethodSelectorEvent, SortMethodSelectorState> {
  SortMethodSelectorBloc() : super(const SortMethodSelectorInitial()) {
    on<SortMethodSelectorSelectingStarted>(_onSelectingStarted);
    on<SortMethodSelectorPreviousSelected>(_onPreviousSelected);
    on<SortMethodSelectorNextSelected>(_onNextSelected);
    on<SortMethodSelectorSelectingCanceled>(_onSelectingCanceled);
    on<SortMethodSelectorSelectingCompleted>(_onSelectingCompleted);
  }

  void _onSelectingStarted(
    SortMethodSelectorSelectingStarted event,
    Emitter<SortMethodSelectorState> emit,
  ) async {
    try {
      if (state is! SortMethodSelectorInitial) return;

      const sortMethods = SortMethod.values;

      emit(SortMethodSelectorProcessing(
        sortMethods: sortMethods,
        currentIndex: sortMethods.indexOf(event.sortMethod),
        selectedIndex: 0,
      ));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in SortMethodSelectorBloc._onSelectingStarted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onPreviousSelected(
    SortMethodSelectorPreviousSelected event,
    Emitter<SortMethodSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! SortMethodSelectorProcessing) return;

      if (currentState.selectedIndex > 0) {
        emit(currentState.copyWith(currentState.selectedIndex - 1));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in SortMethodSelectorBloc._onPreviousSelected",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onNextSelected(
    SortMethodSelectorNextSelected event,
    Emitter<SortMethodSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! SortMethodSelectorProcessing) return;

      if (currentState.selectedIndex < currentState.sortMethods.length - 1) {
        emit(currentState.copyWith(currentState.selectedIndex + 1));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in SortMethodSelectorBloc._onNextSelected",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onSelectingCanceled(
    SortMethodSelectorSelectingCanceled event,
    Emitter<SortMethodSelectorState> emit,
  ) async {
    try {
      if (state is! SortMethodSelectorProcessing) return;

      emit(const SortMethodSelectorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in SortMethodSelectorBloc._onSelectingCanceled",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onSelectingCompleted(
    SortMethodSelectorSelectingCompleted event,
    Emitter<SortMethodSelectorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! SortMethodSelectorProcessing) return;

      if (event.callback != null) {
        event.callback!(currentState.sortMethods[currentState.selectedIndex]);
      }

      emit(const SortMethodSelectorInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in SortMethodSelectorBloc._onSelectingCompleted",
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
