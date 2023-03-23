import 'dart:async';

import 'package:flutter/material.dart';
import 'package:match_recorder/models/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/team.dart';
import 'package:match_recorder/team_page.dart';

class AppState with ChangeNotifier {
  Team team1 = Team('Team 1', []);
  Team team2 = Team('Team 2', []);
  List<BaseEvent> events = [];

  void pushEvent(BaseEvent event) {
    events.add(event);
    notifyListeners();
  }

  void addPlayer(Player player, TeamType teamType) {
    //provvisorio, da cambiare con logica definitiva gestione team
    if (teamType == TeamType.team1) {
      team1.players.add(player);
    } else {
      team2.players.add(player);
    }
    notifyListeners();
  }

  Team getTeam(TeamType teamType) {
    switch (teamType) {
      case TeamType.team1:
        return team1;
      case TeamType.team2:
        return team2;
    }
  }
}
