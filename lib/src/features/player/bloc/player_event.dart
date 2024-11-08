part of 'player_bloc.dart';

sealed class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

final class PlayerStarted extends PlayerEvent {
  const PlayerStarted(this.record, [this.onStopped]);

  final Record record;
  final void Function()? onStopped;
}

final class PlayerPaused extends PlayerEvent {
  const PlayerPaused();
}

// final class PlayerResumed extends PlayerEvent {
//   const PlayerResumed();
// }

final class PlayerStopped extends PlayerEvent {
  const PlayerStopped([this.onStopped]);

  final void Function()? onStopped;
}

final class PlayerNextPosition extends PlayerEvent {
  const PlayerNextPosition();
}

final class PlayerPreviousPosition extends PlayerEvent {
  const PlayerPreviousPosition();
}

final class _PlayerPositionChanged extends PlayerEvent {
  const _PlayerPositionChanged(this.position);

  final Duration position;
}

// final class _PlayerDurationChanged extends PlayerEvent {
//   const _PlayerDurationChanged(this.duration);

//   final Duration duration;
// }
