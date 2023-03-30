import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:provider/provider.dart';

class YellowCardPlayer extends StatelessWidget {
  final Player player;
  final Duration infractionTime;

  const YellowCardPlayer(
      {Key? key, required this.player, required this.infractionTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopwatchState = Provider.of<StopwatchState>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(player.name),
        ValueListenableBuilder(
            valueListenable: stopwatchState.currentDuration,
            builder: (ctx, value, child) {
              final remainingTime =
                  ((infractionTime + const Duration(minutes: 10)) - value);
              return Text(
                  '${remainingTime.inMinutes.toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}');
            }),
        IconButton(
            onPressed: () {
              context.read<AppState>().playerBackInGame(player);
            },
            icon: const Icon(Icons.back_hand))
      ],
    );
  }
}
