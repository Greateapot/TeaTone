import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart' as audioplayers;

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerInitial()) {
    _audioPlayer = audioplayers.AudioPlayer();

    on<PlayerStarted>(_onStarted);
    on<PlayerPaused>(_onPaused);
    // on<PlayerResumed>(_onResumed);
    on<PlayerStopped>(_onStopped);

    on<_PlayerPositionChanged>(_onPositionChanged);
    on<_PlayerDurationChanged>(_onDurationChanged);
  }

  late final audioplayers.AudioPlayer _audioPlayer;

  late StreamSubscription<void>? _playerStateChangedSubscription;
  late StreamSubscription<Duration?>? _durationChangedSubscription;
  late StreamSubscription<Duration>? _positionChangedSubscription;

  void _onStarted(
    PlayerStarted event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      if (state is! PlayerInitial) return;

      _playerStateChangedSubscription = _audioPlayer.onPlayerComplete.listen(
        (_) => add(const PlayerStopped()),
      );
      _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
        (position) => add(_PlayerPositionChanged(position)),
      );
      _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
        (duration) => add(_PlayerDurationChanged(duration)),
      );

      await _audioPlayer.play(audioplayers.DeviceFileSource(event.path));

      emit(const PlayerRunInProgress(
        duration: Duration(),
        position: Duration(),
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

      emit(const PlayerInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in PlayerBloc._onStopped",
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

  void _onDurationChanged(
    _PlayerDurationChanged event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      if (state is PlayerRunInProgress) {
        emit(PlayerRunInProgress(
          position: state.position,
          duration: event.duration,
        ));
      } else if (state is PlayerRunPause) {
        emit(PlayerRunPause(
          position: state.position,
          duration: event.duration,
        ));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in PlayerBloc._onDurationChanged",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

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
    await _durationChangedSubscription?.cancel();
    await _positionChangedSubscription?.cancel();
    return super.close();
  }
}
