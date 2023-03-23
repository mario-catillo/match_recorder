import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/team_page.dart';

abstract class BaseEvent {
  final String time;
  final String name;

  TeamType teamType;
  List<Player> players = [];

  BaseEvent(
      {required this.time, required this.name, this.teamType = TeamType.team1});

  String getEventName();
}
