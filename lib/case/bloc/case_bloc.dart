import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teatone/player/player.dart';
import 'package:teatone/recorder/recorder.dart';

part 'case_event.dart';
part 'case_state.dart';

typedef ContextReader = T Function<T>();

class CaseBloc extends Bloc<CaseEvent, CaseState> {
  CaseBloc() : super(const CaseInitial()) {
    /// on Key Press
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

    /// Special
    on<CaseRecordSelected>(_onRecordSelected);
  }

  /// Обратная сторона лютого костыля
  late ContextReader _contextReader;
  set contextReader(ContextReader value) => _contextReader = value;

  void _onRecordButtonPressed(
    CaseRecordButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseInitial) {
      /// recorder started
      emit(const CaseRecorderRunInProgress());
      _contextReader<RecorderBloc>().add(const RecorderStarted());
    }
  }

  void _onPauseButtonPressed(
    CasePauseButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecorderRunInProgress) {
      /// recorder paused
      emit(const CaseRecorderRunPause());
      _contextReader<RecorderBloc>().add(const RecorderPaused());
    } else if (state is CaseRecorderRunPause) {
      /// recorder resumed
      emit(const CaseRecorderRunInProgress());
      _contextReader<RecorderBloc>().add(const RecorderResumed());
    } else if (state is CasePlayerRunInProgress) {
      /// player paused
      emit(const CasePlayerRunPause());
      _contextReader<PlayerBloc>().add(const PlayerPaused());
    } else if (state is CasePlayerRunPause) {
      /// player resumed
      emit(const CasePlayerRunInProgress());
      _contextReader<PlayerBloc>().add(const PlayerResumed());
    }
  }

  void _onPlayButtonPressed(
    CasePlayButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseInitial) {
      /// select record for player
      // TODO: add event to record selector bloc
    } else if (state is CaseRecorderRunPause) {
      /// recorder resumed
      emit(const CaseRecorderRunInProgress());
      _contextReader<RecorderBloc>().add(const RecorderResumed());
    } else if (state is CasePlayerRunPause) {
      /// player resumed
      emit(const CasePlayerRunInProgress());
      _contextReader<PlayerBloc>().add(const PlayerResumed());
    }
  }

  void _onStopButtonPressed(
    CaseStopButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecorderRunInProgress || state is CaseRecorderRunPause) {
      /// recorder stopped
      emit(const CaseInitial());
      _contextReader<RecorderBloc>().add(const RecorderStopped());
    } else if (state is CasePlayerRunInProgress ||
        state is CasePlayerRunPause) {
      /// player stopped
      emit(const CaseInitial());
      _contextReader<PlayerBloc>().add(const PlayerStopped());
    }
  }

  void _onUpButtonPressed(
    CaseUpButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CasePlayerRecordSelecting ||
        state is CaseDeletingRecordSelecting) {
      // TODO: add event to record selector bloc
    }
  }

  void _onDownButtonPressed(
    CaseDownButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CasePlayerRecordSelecting ||
        state is CaseDeletingRecordSelecting) {
      // TODO: add event to record selector bloc
    }
  }

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
  ) {
    if (state is CaseInitial) {
      /// select record for deleting
      // TODO: add event to record selector bloc
    }
  }

  void _onSettingsButtonPressed(
    CaseSettingsButtonPressed event,
    Emitter<CaseState> emit,
  ) {}

  void _onRecordSelected(
    CaseRecordSelected event,
    Emitter<CaseState> emit,
  ) {
    if (state is CasePlayerRecordSelecting) {
      /// player started
      emit(const CasePlayerRunInProgress());
      _contextReader<PlayerBloc>().add(PlayerStarted(event.path));
    } else if (state is CaseDeletingRecordSelecting) {
      /// deleting record
      // TODO: delete record
    }
  }
}
