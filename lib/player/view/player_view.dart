import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatone/player/player.dart';
import 'package:teatone/shared/shared.dart';

part 'player_run_in_progress_view.dart';
part 'player_run_pause_view.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) => switch (state) {
        PlayerInitial() => const LoadingView(),
        PlayerRunInProgress() => const PlayerRunInProgressView(),
        PlayerRunPause() => const PlayerRunPauseView(),
      },
    );
  }
}
