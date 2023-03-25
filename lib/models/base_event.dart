import 'package:flutter/material.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/team_page.dart';
import 'package:uuid/uuid.dart';

abstract class BaseEvent {
  final String time;
  final String name;
  final String uuid;
  Offset fieldPosition;

  TeamType teamType;
  List<Player> players = [];

  BaseEvent(
      {required this.time,
      required this.name,
      this.teamType = TeamType.team1,
      this.fieldPosition = Offset.zero})
      : uuid = const Uuid().v4();

  String getEventName();
}
