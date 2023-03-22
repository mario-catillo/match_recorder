import 'dart:async';

import 'package:flutter/material.dart';
import 'package:match_recorder/models/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/team.dart';

class AppState with ChangeNotifier {
  Team team1 = Team('Team 1', []);
  Team team2 = Team('Team 2', []);
  List<BaseEvent> events = [];

  void pushEvent(BaseEvent event) {
    events.add(event);
    notifyListeners();
  }

  void addPlayer(Player player) {
    //provvisorio, da cambiare con logica definitiva gestione team
    team1.players.add(player);
    team2.players.add(player);
    notifyListeners();
  }
}
