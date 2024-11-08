part of 'player_bloc.dart';

sealed class PlayerState extends Equatable {
  const PlayerState({
    required this.state,
    this.duration,
    this.position,
  });

  final audioplayers.PlayerState state;
  final Duration? duration;
  final Duration? position;

  @override
  List<Object?> get props => [state, duration, position];
}

final class PlayerInitial extends PlayerState {
  const PlayerInitial({
    super.state = audioplayers.PlayerState.stopped,
    super.duration,
    super.position,
  });
}

final class PlayerRunInProgress extends PlayerState {
  const PlayerRunInProgress({
    super.state = audioplayers.PlayerState.playing,
    required super.duration,
    required super.position,
  });
}

final class PlayerRunPause extends PlayerState {
  const PlayerRunPause({
    super.state = audioplayers.PlayerState.paused,
    required super.duration,
    required super.position,
  });
}
