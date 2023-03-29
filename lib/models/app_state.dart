import 'dart:async';

import 'package:flutter/material.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/team.dart';
import 'package:match_recorder/team_page.dart';

class AppState with ChangeNotifier {
  Team team1 = Team('Team 1', []);
  Team team2 = Team('Team 2', []);
  List<BaseEvent> events = [];
  Player? defaultThrower;

  void pushEvent(BaseEvent event) {
    int index = events.indexWhere((element) => element.uuid == event.uuid);
    if (index != -1) {
      events[index] = event;
    } else {
      events.add(event);
    }
    notifyListeners();
  }

  void dropEvent(BaseEvent event) {
    events.removeWhere((element) => element.uuid == event.uuid);
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

  void setTeam(Team team, TeamType teamType) {
    switch (teamType) {
      case TeamType.team1:
        team1 = team;
        break;
      case TeamType.team2:
        team2 = team;
        break;
    }
    notifyListeners();
  }
}
