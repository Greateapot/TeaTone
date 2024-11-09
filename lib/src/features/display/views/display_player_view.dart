import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/src/features/player/player.dart';

import 'display_loading_view.dart';

class DisplayPlayerView extends StatelessWidget {
  const DisplayPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) => switch (state) {
        PlayerInitial() => const DisplayLoadingView(),
        PlayerRunInProgress() => PlayerRunInProgressView(
            duration: state.duration,
            position: state.position,
          ),
        PlayerRunPause() => PlayerRunPauseView(
            duration: state.duration,
            position: state.position,
          ),
      },
    );
  }
}
