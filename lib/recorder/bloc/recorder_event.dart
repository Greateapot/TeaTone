part of 'recorder_bloc.dart';

sealed class RecorderEvent extends Equatable {
  const RecorderEvent();

  @override
  List<Object?> get props => [];
}

final class RecorderStarted extends RecorderEvent {
  const RecorderStarted();
}

final class RecorderPaused extends RecorderEvent {
  const RecorderPaused();
}

final class RecorderResumed extends RecorderEvent {
  const RecorderResumed();
}

final class RecorderStopped extends RecorderEvent {
  const RecorderStopped();
}

final class _RecorderTimerTicked extends RecorderEvent {
  const _RecorderTimerTicked();
}
