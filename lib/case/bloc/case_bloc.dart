import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teatone/recorder/recorder.dart';

part 'case_event.dart';
part 'case_state.dart';

typedef ContextReader = T Function<T>();

class CaseBloc extends Bloc<CaseEvent, CaseState> {
  CaseBloc() : super(const CaseInitial()) {
    on<CaseRecordButtonPressed>(_onRecordButtonPressed);
    on<CasePauseButtonPressed>(_onPauseButtonPressed);
    on<CasePlayButtonPressed>(_onPlayButtonPressed);
    on<CaseStopButtonPressed>(_onStopButtonPressed);
    on<CaseUpButtonPressed>(_onUpButtonPressed);
    on<CaseDownButtonPressed>(_onDownButtonPressed);
    on<CaseLeftButtonPressed>(_onLeftButtonPressed);
    on<CaseRightButtonPressed>(_onRightButtonPressed);
    on<CaseConfirmButtonPressed>(_onConfirmButtonPressed);
    on<CaseCancelButtonPressed>(_onCancelButtonPressed);
    on<CaseDeleteButtonPressed>(_onDeleteButtonPressed);
    on<CaseSettingsButtonPressed>(_onSettingsButtonPressed);
  }

  /// Обратная сторона лютого костыля
  late ContextReader _contextReader;
  set contextReader(ContextReader value) => _contextReader = value;

  void _onRecordButtonPressed(
    CaseRecordButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseInitial) {
      emit(const CaseRecorderRunInProgress());
      _contextReader<RecorderBloc>().add(const RecorderStarted());
    }
  }

  void _onPauseButtonPressed(
    CasePauseButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecorderRunInProgress) {
      emit(const CaseRecorderRunPause());
      _contextReader<RecorderBloc>().add(const RecorderPaused());
    } else if (state is CaseRecorderRunPause) {
      emit(const CaseRecorderRunInProgress());
      _contextReader<RecorderBloc>().add(const RecorderResumed());
    }
  }

  void _onPlayButtonPressed(
    CasePlayButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecorderRunPause) {
      emit(const CaseRecorderRunInProgress());
      _contextReader<RecorderBloc>().add(const RecorderResumed());
    }
  }

  void _onStopButtonPressed(
    CaseStopButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecorderRunInProgress || state is CaseRecorderRunPause) {
      emit(const CaseInitial());
      _contextReader<RecorderBloc>().add(const RecorderStopped());
    }
  }

  void _onUpButtonPressed(
    CaseUpButtonPressed event,
    Emitter<CaseState> emit,
  ) {}
  void _onDownButtonPressed(
    CaseDownButtonPressed event,
    Emitter<CaseState> emit,
  ) {}
  void _onLeftButtonPressed(
    CaseLeftButtonPressed event,
    Emitter<CaseState> emit,
  ) {}
  void _onRightButtonPressed(
    CaseRightButtonPressed event,
    Emitter<CaseState> emit,
  ) {}

  void _onConfirmButtonPressed(
    CaseConfirmButtonPressed event,
    Emitter<CaseState> emit,
  ) {}
  void _onCancelButtonPressed(
    CaseCancelButtonPressed event,
    Emitter<CaseState> emit,
  ) {}
  void _onDeleteButtonPressed(
    CaseDeleteButtonPressed event,
    Emitter<CaseState> emit,
  ) {}
  void _onSettingsButtonPressed(
    CaseSettingsButtonPressed event,
    Emitter<CaseState> emit,
  ) {}
}
