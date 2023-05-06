import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/widgets/YellowCardPlayer.dart';
import 'package:provider/provider.dart';

class CardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: Consumer<AppState>(builder: (ctx, appState, child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final player =
                appState.yellowCardPlayers.entries.toList()[index].key;
            final infractionTime = appState.yellowCardPlayers[player]!;
            return YellowCardPlayer(
                player: player, infractionTime: infractionTime);
          },
          itemCount: appState.yellowCardPlayers.entries.length,
        );
      }),
    );
  }
}
