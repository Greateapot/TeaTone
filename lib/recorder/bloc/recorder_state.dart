part of 'recorder_bloc.dart';

sealed class RecorderState extends Equatable {
  const RecorderState({
    required this.state,
    required this.duration,
  });

  final RecordState state;
  final int duration;

  @override
  List<Object?> get props => [state, duration];

  @override
  String toString() => 'RecorderState(state: $state, duration: $duration)';
}

final class RecorderInitial extends RecorderState {
  const RecorderInitial({
    super.state = RecordState.stop,
    super.duration = -10,
  });

  @override
  String toString() => 'RecorderInitial(state: $state, duration: $duration)';
}

final class RecorderRunInProgress extends RecorderState {
  const RecorderRunInProgress({
    super.state = RecordState.record,
    required super.duration,
  });

  @override
  String toString() =>
      'RecorderRunInProgress(state: $state, duration: $duration)';
}

final class RecorderRunPause extends RecorderState {
  const RecorderRunPause({
    super.state = RecordState.pause,
    required super.duration,
  });

  @override
  String toString() => 'RecorderRunPause(state: $state,  duration: $duration)';
}
