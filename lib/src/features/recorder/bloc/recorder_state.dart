part of 'recorder_bloc.dart';

sealed class RecorderState extends Equatable {
  const RecorderState({
    required this.title,
    required this.state,
    required this.duration,
  });

  final String? title;
  final RecordState state;
  final int duration;

  @override
  List<Object?> get props => [state, duration, title];
}

final class RecorderInitial extends RecorderState {
  const RecorderInitial({
    super.state = RecordState.stop,
    super.duration = -1,
    super.title,
  });
}

final class RecorderRunInProgress extends RecorderState {
  const RecorderRunInProgress({
    super.state = RecordState.record,
    required super.duration,
    super.title,
  });
}

final class RecorderRunPause extends RecorderState {
  const RecorderRunPause({
    super.state = RecordState.pause,
    required super.duration,
    super.title,
  });
}

final class RecorderCompleted extends RecorderState {
  const RecorderCompleted({
    super.state = RecordState.stop,
    required super.duration,
    super.title,
  });
}
