import 'dart:async';
import 'dart:convert';
import 'dart:developer' as Developer;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/events/infraction_event.dart';
import 'package:match_recorder/models/events/unknown_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/serializable.dart';
import 'package:match_recorder/models/team.dart';
import 'package:match_recorder/team_page.dart';
import 'package:path_provider/path_provider.dart';

class AppState with ChangeNotifier implements Serializable {
  Team team1 = Team('Team 1', []);
  Team team2 = Team('Team 2', []);

  List<BaseEvent> events = [];
  Player? defaultThrower;

  Map<Player, Duration> yellowCardPlayers = {};
  AppState();

  void pushEvent(BaseEvent event) {
    int index = events.indexWhere((element) => element.uuid == event.uuid);
    if (index != -1) {
      events[index] = event;
    } else {
      events.add(event);
      if (event is InfractionEvent &&
          event.infractionPlayer != null &&
          event.cardStatus == CardStatus.yellow) {
        yellowCardPlayers[event.infractionPlayer!] = event.duration;
      }
    }
    notifyListeners();
  }

  void playerBackInGame(Player player) {
    yellowCardPlayers.remove(player);
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

  Future<void> saveMatchToFile(String name) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    //debug print directory path
    debugPrint(directory.path);
    final File file = File('${directory.path}/$name.json');
    await file.writeAsString(toJson());
  }

  Future<List<String>> getSavedMatches() async {
    List<String> matches = [];
    await getApplicationDocumentsDirectory().then((value) {
      value.listSync().forEach((element) {
        if (element.path.endsWith('.json')) {
          matches.add(element.path.split('/').last);
        }
      });
    });
    return matches;
  }

  @override
  String toJson() {
    return jsonEncode({
      'team1': team1.toJson(),
      'team2': team2.toJson(),
      'events': events
          .map((e) => {"type": e.runtimeType.toString(), "event": e.toJson()})
          .toList(),
    });
  }

  Future<void> loadMatchFromFile(String name) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$name');
    String json = await file.readAsString();
    AppState loadedState = AppState.fromJson(json);
    team1 = loadedState.team1;
    team2 = loadedState.team2;
    events = loadedState.events;
    notifyListeners();
  }

  @override
  AppState.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    team1 = Team.fromJson(map['team1']);
    team2 = Team.fromJson(map['team2']);
    events = (map['events'])
        .map((e) {
          debugPrint(e.toString());
          //unserialize type from e which is a MapEntry
          switch (e['type']) {
            case 'InfractionEvent':
              return InfractionEvent.fromJson(e['event']);
            default:
              return UnknownEvent.fromJson(e['event']);
          }
        })
        .toList()
        .cast<BaseEvent>();
  }

  void saveCsv() async {
    List<String> csvCols = [
      "ID",
      "Realtime",
      "Time (h:min:sec)",
      "Time (Sec)",
      "Event Name",
      "Position",
      "Team",
      "Player 1",
      "Player 2",
      "Restart / Kick off",
      "Advance",
      "Shoulder",
      "Turnover",
      "Infraction",
      "Card",
      "Kick",
      "Goal kick",
      "Result",
      "Line Result",
      "Line quantity",
      "Line Position",
      "Points",
      "Break",
      "Ruck speed",
    ];
    String csv = '${csvCols.join(',')}\n';
    int progressive = 1;
    events.forEach((element) {
      csv += "${element.toCsv(progressive, this)}\n";
      progressive++;
    });

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/match.csv');
    file.writeAsString(csv);
  }
}
