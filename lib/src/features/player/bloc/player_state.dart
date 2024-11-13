part of 'player_bloc.dart';

sealed class PlayerState extends Equatable {
  const PlayerState({
    required this.state,
    this.title,
    this.duration,
    this.position,
  });

  final audioplayers.PlayerState state;
  final String? title;
  final Duration? duration;
  final Duration? position;

  @override
  List<Object?> get props => [state, title, duration, position];
}

final class PlayerInitial extends PlayerState {
  const PlayerInitial({
    super.state = audioplayers.PlayerState.stopped,
    super.title,
    super.duration,
    super.position,
  });
}

final class PlayerRunInProgress extends PlayerState {
  const PlayerRunInProgress({
    super.state = audioplayers.PlayerState.playing,
    super.title,
    super.duration,
    super.position,
  });
}

final class PlayerRunPause extends PlayerState {
  const PlayerRunPause({
    super.state = audioplayers.PlayerState.paused,
    super.title,
    super.duration,
    super.position,
  });
}
