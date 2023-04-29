import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/widgets/cards_page.dart';
import 'package:provider/provider.dart';

class CardsHeader extends StatelessWidget {
  const CardsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopwatchState = Provider.of<StopwatchState>(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CardsPage())),
          child: Consumer<AppState>(builder: (ctx, appState, child) {
            return Row(
              children: [
                Container(
                    color: Colors.amber,
                    width: 10,
                    height: 15,
                    child: Center(
                      child: Text(
                        appState.yellowCardPlayers.length.toString(),
                        style: const TextStyle(fontSize: 8),
                      ),
                    )),
                SizedBox(
                  width: 5,
                ),
                if (appState.yellowCardPlayers.length > 0)
                  ValueListenableBuilder(
                      valueListenable: stopwatchState.currentDuration,
                      builder: (ctx, value, child) {
                        final remainingTime =
                            ((appState.yellowCardPlayers.values.first +
                                    const Duration(minutes: 10)) -
                                value);
                        return Text(
                          '${remainingTime.inMinutes.toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(fontSize: 10),
                        );
                      })
              ],
            );
          }),
        ),
      ],
    );
  }
}
