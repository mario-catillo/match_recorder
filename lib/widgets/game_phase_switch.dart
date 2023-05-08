import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/widgets/misc/value_listenable_builder2.dart';
import 'package:provider/provider.dart';

class GamePhaseSwitch extends StatelessWidget {
  final StopwatchState stopwatchState;
  final GameStatus gameStatus;
  const GamePhaseSwitch({
    super.key,
    required this.stopwatchState,
    required this.gameStatus,
  });

  @override
  Widget build(BuildContext context) {
    Map<GameStatus, String> gameStatusMap = {
      GameStatus.attack: "Attack",
      GameStatus.defense: "Defence",
      GameStatus.nullTime: "Stopped"
    };
    Map<GameStatus, MaterialColor> gameStatusColor = {
      GameStatus.attack: Colors.green,
      GameStatus.defense: Colors.red,
      GameStatus.nullTime: Colors.grey
    };
    Map<GameStatus, Function> actions = {
      GameStatus.attack: () => stopwatchState.setAttackTime(),
      GameStatus.defense: () => stopwatchState.setDefenseTime(),
      GameStatus.nullTime: () => stopwatchState.setNullTime(),
    };
    Map<GameStatus, ValueNotifier> durations = {
      GameStatus.attack: stopwatchState.attackTime,
      GameStatus.defense: stopwatchState.defenseTime,
      GameStatus.nullTime: stopwatchState.nullTime,
    };
    return GestureDetector(
      onTap: () => actions[gameStatus]!(),
      child: Consumer<AppState>(builder: (ctx, appState, _) {
        var textColor = stopwatchState.gameStatus == gameStatus
            ? Colors.white
            : Colors.black;
        return Container(
            color: stopwatchState.gameStatus == gameStatus
                ? gameStatusColor[gameStatus]?.shade800 ?? Colors.grey
                : gameStatusColor[gameStatus]?.shade100 ?? Colors.grey,
            child: Column(children: [
              Text(gameStatusMap[gameStatus] ?? '?',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w200)),
              ValueListenableBuilder2(
                  first: durations[gameStatus]!,
                  second: stopwatchState.currentDuration,
                  builder: (ctx, time, duration, child) {
                    double percentage =
                        ((time.inSeconds / duration.inSeconds) * 100);
                    if (percentage.isNaN) {
                      percentage = 0;
                    }
                    percentage = percentage.roundToDouble();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            " ${time.inMinutes.toString().padLeft(2, '0')}:${(time.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w200)),
                        const SizedBox(width: 10),
                        Text(
                          "$percentage%",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  })
            ]));
      }),
    );
  }
}
