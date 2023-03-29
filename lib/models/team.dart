import 'dart:convert';

import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/serializable.dart';

class Team implements Serializable {
  final String name;
  final List<Player> players;

  Team(this.name, this.players);

  @override
  String toJson() {
    return jsonEncode({
      'name': name,
      'players': players.map((e) => e.toJson()).toList(),
    });
  }

  @override
  Team.fromJson(String json)
      : name = jsonDecode(json)['name'],
        players = (jsonDecode(json)['players'] as List)
            .map((e) => Player.fromJson(e))
            .toList();
}
