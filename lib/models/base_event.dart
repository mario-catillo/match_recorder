import 'package:match_recorder/models/player.dart';

abstract class BaseEvent {
  final String time;
  final String name;
  List<Player> players = [];

  BaseEvent({required this.time, required this.name});

  String getEventName();
}
