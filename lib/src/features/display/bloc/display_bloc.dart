import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'display_event.dart';
part 'display_state.dart';

class DisplayBloc extends Bloc<DisplayEvent, DisplayState> {
  DisplayBloc({this.noticeDelay = const Duration(seconds: 1)})
      : super(const DisplayHome(isDisplayOff: false)) {
    on<DisplayStateChanged>(_onStateChanged);
    on<DisplayHomeDisplayed>(_onHomeDisplayed);
    on<DisplayFailedDisplayed>(_onFailedDisplayed);
    on<DisplayCanceledDisplayed>(_onCanceledDisplayed);
    on<DisplayDoneDisplayed>(_onDoneDisplayed);
    on<DisplayRecorderDisplayed>(_onRecorderDisplayed);
    on<DisplayPlayerDisplayed>(_onPlayerDisplayed);
    on<DisplayDeletorDisplayed>(_onDeletorDisplayed);
    on<DisplayRecordSelectorDisplayed>(_onRecordSelectorDisplayed);
  }

  final Duration noticeDelay;

  void _onStateChanged(
    DisplayStateChanged event,
    Emitter<DisplayState> emit,
  ) async {
    emit(state.copyWith(isDisplayOff: !state.isDisplayOff));
  }

  void _onHomeDisplayed(
    DisplayHomeDisplayed event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayHome(isDisplayOff: state.isDisplayOff));
  }

  void _onFailedDisplayed(
    DisplayFailedDisplayed event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayFailed(isDisplayOff: state.isDisplayOff));

    await Future.delayed(
      noticeDelay,
      () => emit(DisplayHome(isDisplayOff: state.isDisplayOff)),
    );
  }

  void _onCanceledDisplayed(
    DisplayCanceledDisplayed event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayCanceled(isDisplayOff: state.isDisplayOff));

    await Future.delayed(
      noticeDelay,
      () => emit(DisplayHome(isDisplayOff: state.isDisplayOff)),
    );
  }

  void _onDoneDisplayed(
    DisplayDoneDisplayed event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayDone(isDisplayOff: state.isDisplayOff));

    await Future.delayed(
      noticeDelay,
      () => emit(DisplayHome(isDisplayOff: state.isDisplayOff)),
    );
  }

  void _onRecorderDisplayed(
    DisplayRecorderDisplayed event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayRecorder(isDisplayOff: state.isDisplayOff));
  }

  void _onPlayerDisplayed(
    DisplayPlayerDisplayed event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayPlayer(isDisplayOff: state.isDisplayOff));
  }

  void _onDeletorDisplayed(
    DisplayDeletorDisplayed event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayDeletor(isDisplayOff: state.isDisplayOff));
  }

  void _onRecordSelectorDisplayed(
    DisplayRecordSelectorDisplayed event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayRecordSelector(
      event.type,
      isDisplayOff: state.isDisplayOff,
    ));
  }
}
