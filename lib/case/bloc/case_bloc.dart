import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teatone/player/player.dart';
import 'package:teatone/record_selector/record_selector.dart';
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

    /// Special (two-phased events)
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
      _contextReader<RecorderBloc>().add(const RecorderPaused());
    } else if (state is CasePlayerRunInProgress) {
      /// player paused
      _contextReader<PlayerBloc>().add(const PlayerPaused());
    }
  }

  void _onPlayButtonPressed(
    CasePlayButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseInitial) {
      /// select record for player
      emit(const CaseRecordSelectorRunInProgress(
        RecordSelectingInitiatorType.player,
      ));
      _contextReader<RecordSelectorBloc>().add(const RecordSelectorStarted());
    }
  }

  void _onStopButtonPressed(
    CaseStopButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecorderRunInProgress) {
      /// recorder stopped
      emit(const CaseInitial());
      _contextReader<RecorderBloc>().add(const RecorderStopped());
    } else if (state is CasePlayerRunInProgress) {
      /// player stopped
      emit(const CaseInitial());
      _contextReader<PlayerBloc>().add(const PlayerStopped());
    }
  }

  void _onUpButtonPressed(
    CaseUpButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecordSelectorRunInProgress) {
      /// select previous record
      _contextReader<RecordSelectorBloc>()
          .add(const RecordSelectorPreviousSelected());
    }
  }

  void _onDownButtonPressed(
    CaseDownButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecordSelectorRunInProgress) {
      /// select next record
      _contextReader<RecordSelectorBloc>()
          .add(const RecordSelectorNextSelected());
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
  ) {
    if (state is CaseRecordSelectorRunInProgress) {
      /// complete record selection
      _contextReader<RecordSelectorBloc>().add(
        RecordSelectorSelectingCompleted(
          (record) {
            add(CaseRecordSelected(record));
          },
        ),
      );
    }
  }

  void _onCancelButtonPressed(
    CaseCancelButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseRecordSelectorRunInProgress) {
      /// cancel record selection
      emit(const CaseInitial());
      _contextReader<RecordSelectorBloc>()
          .add(const RecordSelectorSelectingCanceled());
    }
  }

  void _onDeleteButtonPressed(
    CaseDeleteButtonPressed event,
    Emitter<CaseState> emit,
  ) {
    if (state is CaseInitial) {
      /// select record for player
      emit(const CaseRecordSelectorRunInProgress(
        RecordSelectingInitiatorType.deletor,
      ));
      _contextReader<RecordSelectorBloc>().add(const RecordSelectorStarted());
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
    if (state is CaseRecordSelectorRunInProgress) {
      switch ((state as CaseRecordSelectorRunInProgress).type) {
        case RecordSelectingInitiatorType.player:

          /// player started
          emit(const CasePlayerRunInProgress());
          _contextReader<PlayerBloc>().add(PlayerStarted(event.path));
        case RecordSelectingInitiatorType.deletor:

        /// deleting record
        // TODO: Handle this case.
      }
    }
  }
}
