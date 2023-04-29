import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/serializable.dart';
import 'package:match_recorder/team_page.dart';
import 'package:uuid/uuid.dart';

abstract class BaseEvent implements Serializable {
  final Duration duration;
  final String name;
  final String uuid;
  final DateTime timestamp = DateTime.now();
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

  T? getDescriptorValue<T>();
  //  T? getDescriptorValue<T>();
  setDescriptorValue<T>(T value);

  String descriptorValueString(value) {
    return value.toString().split('.').last;
  }

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

// save a simple csv to document directory
  String toCsv(int progressive, AppState appState) {
    // String restartTypeString = getDescriptorValue<RestartType>().toString().split('.').last;

    String eventRow0 = [
      progressive.toString(),
      timestamp.toIso8601String(),
      '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      duration.inSeconds, // duration in seconds
      name, //event name
      'x-y', //field position
      appState.getTeam(teamType).name, // team name
      // getPlayers().values.first?.name ?? '-', //Player 1
      // getPlayers().values.elementAt(1)?.name ?? '-', // Player 2
      getPlayers().values.isNotEmpty
          ? getPlayers().values.first?.name ?? ' '
          : ' ', //Player 1
      getPlayers().values.isNotEmpty
          ? getPlayers().values.first?.name ?? ' '
          : ' ', //Player 2
      getDescriptorValue<RestartType>().toString().split('.').last,
      getDescriptorValue<MovementProgression>().toString().split('.').last,
      getDescriptorValue<TackleShoulder>().toString().split('.').last,
      getDescriptorValue<Turnover>().toString().split('.').last,
      getDescriptorValue<Infraction>().toString().split('.').last,
      getDescriptorValue<CardStatus>().toString().split('.').last,
      getDescriptorValue<KickType>().toString().split('.').last,
      getDescriptorValue<GoalKick>().toString().split('.').last,
      getDescriptorValue<Result>().toString().split('.').last,
      getDescriptorValue<LineResult>().toString().split('.').last,
      getDescriptorValue<LineQuantity>().toString().split('.').last,
      getDescriptorValue<LinePosition>().toString().split('.').last,
      getDescriptorValue<Points>().toString().split('.').last,
      getDescriptorValue<BreakType>().toString().split('.').last,
      getDescriptorValue<Speed>().toString().split('.').last,
    ].join(',');

    String eventRow = eventRow0.replaceAll('null', ' ');

    return eventRow;
  }
}
