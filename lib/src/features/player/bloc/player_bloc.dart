import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:teatone/src/features/storage/storage.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc(this.storageRepository) : super(const PlayerInitial()) {
    _audioPlayer = audioplayers.AudioPlayer();

    on<PlayerStarted>(_onStarted);
    on<PlayerPaused>(_onPaused);
    // on<PlayerResumed>(_onResumed);
    on<PlayerStopped>(_onStopped);

    on<PlayerNextPosition>(_onNextPosition);
    on<PlayerPreviousPosition>(_onPreviousPosition);

    on<_PlayerPositionChanged>(_onPositionChanged);
    // on<_PlayerDurationChanged>(_onLocalDurationChanged);
  }

  final StorageRepository storageRepository;

  late final audioplayers.AudioPlayer _audioPlayer;

  late StreamSubscription<void>? _playerStateChangedSubscription;
  // late StreamSubscription<Duration?>? _durationChangedSubscription;
  late StreamSubscription<Duration>? _positionChangedSubscription;

  void _onStarted(
    PlayerStarted event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      if (state is! PlayerInitial) return;

      _playerStateChangedSubscription = _audioPlayer.onPlayerComplete.listen(
        (_) => add(PlayerStopped(event.onStopped)),
      );
      _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
        (position) => add(_PlayerPositionChanged(position)),
      );

      final source = audioplayers.DeviceFileSource(event.record.path);

      await _audioPlayer.setSource(source);
      await _audioPlayer.setVolume(0.5);

      final duration = await _audioPlayer.getDuration();
      final position = await _audioPlayer.getCurrentPosition();

      await _audioPlayer.resume();

      emit(PlayerRunInProgress(
        duration: duration,
        position: position,
      ));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in PlayerBloc._onStarted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onPaused(
    PlayerPaused event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      if (state is PlayerRunInProgress) {
        /// player paused
        await _audioPlayer.pause();

        emit(PlayerRunPause(
          duration: state.duration,
          position: state.position,
        ));
      } else if (state is PlayerRunPause) {
        /// player resumed
        await _audioPlayer.resume();

        emit(PlayerRunInProgress(
          duration: state.duration,
          position: state.position,
        ));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in PlayerBloc._onPaused",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // void _onResumed(
  //   PlayerResumed event,
  //   Emitter<PlayerState> emit,
  // ) async {
  //   try {
  //     if (state is! PlayerRunPause) return;

  //     await _audioPlayer.resume();

  //     emit(PlayerRunInProgress(
  //       duration: state.duration,
  //       position: state.position,
  //     ));
  //   } catch (error, stackTrace) {
  //     _log(
  //       "Encountered an error in PlayerBloc._onResumed",
  //       error: error,
  //       stackTrace: stackTrace,
  //     );
  //   }
  // }

  void _onStopped(
    PlayerStopped event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      if (state is! PlayerRunInProgress && state is! PlayerRunPause) return;

      await _audioPlayer.release();

      if (event.onStopped != null) event.onStopped!();

      emit(const PlayerInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in PlayerBloc._onStopped",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onNextPosition(
    PlayerNextPosition event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      final position = state.position ?? Duration.zero;
      final duration = state.duration ?? Duration.zero;
      final milliseconds = position.inMilliseconds + 3 * 1000;
      final nextPosition = (milliseconds > duration.inMilliseconds)
          ? Duration(milliseconds: duration.inMilliseconds)
          : Duration(milliseconds: milliseconds);

      await _audioPlayer.seek(nextPosition);
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in PlayerBloc._onNextPosition",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onPreviousPosition(
    PlayerPreviousPosition event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      final position = state.position ?? Duration.zero;
      final milliseconds = position.inMilliseconds - 3 * 1000;
      final previousPosition = (milliseconds < 0)
          ? Duration.zero
          : Duration(milliseconds: milliseconds);

      await _audioPlayer.seek(previousPosition);
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in PlayerBloc._onPreviousPosition",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onPositionChanged(
    _PlayerPositionChanged event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      if (state is PlayerRunInProgress) {
        emit(PlayerRunInProgress(
          position: event.position,
          duration: state.duration,
        ));
      } else if (state is PlayerRunPause) {
        emit(PlayerRunPause(
          position: event.position,
          duration: state.duration,
        ));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in PlayerBloc._onPositionChanged",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // void _onLocalDurationChanged(
  //   _PlayerDurationChanged event,
  //   Emitter<PlayerState> emit,
  // ) async {
  //   try {
  //     if (state is PlayerRunInProgress) {
  //       emit(PlayerRunInProgress(
  //         position: state.position,
  //         duration: event.duration,
  //       ));
  //     } else if (state is PlayerRunPause) {
  //       emit(PlayerRunPause(
  //         position: state.position,
  //         duration: event.duration,
  //       ));
  //     }
  //   } catch (error, stackTrace) {
  //     _log(
  //       "Encountered an error in PlayerBloc._onLocalDurationChanged",
  //       error: error,
  //       stackTrace: stackTrace,
  //     );
  //   }
  // }

  void _log(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      dev.log(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> close() async {
    await _audioPlayer.dispose();
    await _playerStateChangedSubscription?.cancel();
    // await _durationChangedSubscription?.cancel();
    await _positionChangedSubscription?.cancel();
    return super.close();
  }
}
