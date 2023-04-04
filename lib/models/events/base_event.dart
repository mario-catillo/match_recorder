import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/serializable.dart';
import 'package:match_recorder/team_page.dart';
import 'package:uuid/uuid.dart';

abstract class BaseEvent implements Serializable {
  final Duration duration;
  final String name;
  final String uuid;
  Offset fieldPosition;

  TeamType teamType;

  BaseEvent(
      {required this.duration,
      required this.name,
      this.teamType = TeamType.team1,
      this.fieldPosition = Offset.zero})
      : uuid = const Uuid().v4();

  String getEventName();

  List<Descriptors> getDescriptors() {
    return [];
  }

  Map<String, Player?> getPlayers();
  Player? getPlayer(String key);

  void setPlayer(String key, Player? player);

  T getDescriptorValue<T>();
  setDescriptorValue<T>(T value);

  String getTimeString() {
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  String toJson() {
    return jsonEncode({
      'duration': duration.inMilliseconds,
      'name': name,
      'uuid': uuid,
      'fieldPosition': {"dx": fieldPosition.dx, "dy": fieldPosition.dy},
      'teamType': teamType.index,
    });
  }

  @override
  BaseEvent.fromJson(String json)
      : duration = Duration(milliseconds: jsonDecode(json)['duration']),
        fieldPosition = Offset(jsonDecode(json)['fieldPosition']['dx'],
            jsonDecode(json)['fieldPosition']['dy']),
        name = jsonDecode(json)['name'],
        uuid = jsonDecode(json)['uuid'],
        teamType = TeamType.values[jsonDecode(json)['teamType']];
}
