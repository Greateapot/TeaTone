import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as pathlib;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'recorder_event.dart';
part 'recorder_state.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  RecorderBloc() : super(const RecorderInitial()) {
    _audioRecorder = AudioRecorder();

    on<RecorderStarted>(_onStarted);
    on<RecorderPaused>(_onPaused);
    // on<RecorderResumed>(_onResumed);
    on<RecorderStopped>(_onStopped);
    on<_RecorderTimerTicked>(_onTimerTicked);
  }

  late final AudioRecorder _audioRecorder;

  StreamSubscription? _tickerStreamSubscription;

  void _onStarted(
    RecorderStarted event,
    Emitter<RecorderState> emit,
  ) async {
    const encoder = AudioEncoder.aacLc;
    const config = RecordConfig(encoder: encoder, numChannels: 1);

    try {
      if (state is! RecorderInitial) return;
      if (!await _audioRecorder.hasPermission()) return;
      if (!await _isEncoderSupported(encoder)) return;

      final path = await _getPath();

      await _audioRecorder.start(config, path: path);
      await _startTimer();

      emit(const RecorderRunInProgress(duration: 0));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecorderBloc._onStarted",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onPaused(
    RecorderPaused event,
    Emitter<RecorderState> emit,
  ) async {
    try {
      if (state is RecorderRunInProgress) {
        /// recorder paused
        await _audioRecorder.pause();
        _tickerStreamSubscription?.pause();

        emit(RecorderRunPause(duration: state.duration));
      } else if (state is RecorderRunPause) {
        /// recorded resumed
        await _audioRecorder.resume();
        _tickerStreamSubscription?.resume();

        emit(RecorderRunInProgress(duration: state.duration));
      }
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecorderBloc._onPaused",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // void _onResumed(
  //   RecorderResumed resume,
  //   Emitter<RecorderState> emit,
  // ) async {
  //   try {
  //     if (state is! RecorderRunPause) return;

  //     await _audioRecorder.resume();
  //     // await _startTimer();
  //     _tickerStreamSubscription?.resume();

  //     emit(RecorderRunInProgress(duration: state.duration));
  //   } catch (error, stackTrace) {
  //       _log(
  //         "Encountered an error in RecorderBloc._onResumed",
  //         error: error,
  //         stackTrace: stackTrace,
  //       );
  //   }
  // }

  void _onStopped(
    RecorderStopped event,
    Emitter<RecorderState> emit,
  ) async {
    try {
      if (state is! RecorderRunInProgress && state is! RecorderRunPause) return;

      await _audioRecorder.stop();
      await _tickerStreamSubscription?.cancel();

      emit(const RecorderInitial());
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecorderBloc._onStopped",
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onTimerTicked(
    _RecorderTimerTicked event,
    Emitter<RecorderState> emit,
  ) async {
    try {
      if (state is! RecorderRunInProgress) return;

      emit(RecorderRunInProgress(duration: state.duration + 1));
    } catch (error, stackTrace) {
      _log(
        "Encountered an error in RecorderBloc._onTicked",
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

  Future<bool> _isEncoderSupported(AudioEncoder encoder) async {
    final isSupported = await _audioRecorder.isEncoderSupported(encoder);

    if (!isSupported && kDebugMode) {
      dev.log('${encoder.name} is not supported on this platform.');
      dev.log('Supported encoders are:');

      for (final e in AudioEncoder.values) {
        if (await _audioRecorder.isEncoderSupported(e)) {
          dev.log('- ${e.name}');
        }
      }
    }

    return isSupported;
  }

  Future<String> _getPath() async {
    final dir = await getApplicationDocumentsDirectory();

    return pathlib.join(
      dir.path,
      'teatone_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
  }

  Future<void> _startTimer() async {
    await _tickerStreamSubscription?.cancel();

    _tickerStreamSubscription = Stream.periodic(
      const Duration(seconds: 1),
    ).listen(
      (_) => add(const _RecorderTimerTicked()),
      onError: (error) => _log(
        'Encountered an error in RecorderBloc._startTimer',
        error: error,
      ),
      onDone: () => _log('Ticker stopped'),
      cancelOnError: true,
    );
  }

  @override
  Future<void> close() async {
    await _audioRecorder.dispose();
    await _tickerStreamSubscription?.cancel();
    return super.close();
  }
}
