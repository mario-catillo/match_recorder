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
      'players':
          getPlayers().map((key, value) => MapEntry(key, value?.toJson())),
      'descriptors': getDescriptors().map((e) {
        int? descriptorIndex;
        switch (e) {
          case Descriptors.restartType:
            descriptorIndex = getDescriptorValue<RestartType>()?.index;
            break;
          case Descriptors.movementProgression:
            descriptorIndex = getDescriptorValue<MovementProgression>()?.index;
            break;
          case Descriptors.tackleShoulder:
            descriptorIndex = getDescriptorValue<TackleShoulder>()?.index;
            break;
          case Descriptors.turnover:
            descriptorIndex = getDescriptorValue<Turnover>()?.index;
            break;
          case Descriptors.infraction:
            descriptorIndex = getDescriptorValue<Infraction>()?.index;
            break;
          case Descriptors.cardStatus:
            descriptorIndex = getDescriptorValue<CardStatus>()?.index;
            break;
          case Descriptors.kickType:
            descriptorIndex = getDescriptorValue<KickType>()?.index;
            break;
          case Descriptors.goalKick:
            descriptorIndex = getDescriptorValue<GoalKick>()?.index;
            break;
          case Descriptors.result:
            descriptorIndex = getDescriptorValue<Result>()?.index;
            break;
          case Descriptors.lineResult:
            descriptorIndex = getDescriptorValue<LineResult>()?.index;
            break;
          case Descriptors.lineQuantity:
            descriptorIndex = getDescriptorValue<LineQuantity>()?.index;
            break;
          case Descriptors.linePosition:
            descriptorIndex = getDescriptorValue<LinePosition>()?.index;
            break;
          case Descriptors.points:
            descriptorIndex = getDescriptorValue<Points>()?.index;
            break;
          case Descriptors.breakType:
            descriptorIndex = getDescriptorValue<BreakType>()?.index;
            break;
          case Descriptors.speed:
            descriptorIndex = getDescriptorValue<Speed>()?.index;
            break;
        }
        return {
          'descriptor': e.index,
          'value': descriptorIndex,
        };
      }).toList(),
    });
  }

  @override
  BaseEvent.fromJson(String json)
      : uuid = jsonDecode(json)['uuid'],
        name = jsonDecode(json)['name'],
        duration = Duration(milliseconds: jsonDecode(json)['duration']),
        fieldPosition = Offset(jsonDecode(json)['fieldPosition']['dx'],
            jsonDecode(json)['fieldPosition']['dy']),
        teamType = TeamType.values[jsonDecode(json)['teamType']] {
    jsonDecode(json)['players'].forEach((key, value) {
      if (value != null) {
        setPlayer(key, Player.fromJson((value)));
      }
    });
    jsonDecode(json)['descriptors'].forEach((element) {
      Descriptors descriptor = Descriptors.values[element['descriptor']];
      int? descriptorValue = element['value'];
      switch (descriptor) {
        case Descriptors.restartType:
          if (descriptorValue != null) {
            setDescriptorValue<RestartType>(
                RestartType.values[descriptorValue]);
          }
          break;
        case Descriptors.movementProgression:
          if (descriptorValue != null) {
            setDescriptorValue<MovementProgression>(
                MovementProgression.values[descriptorValue]);
          }
          break;
        case Descriptors.tackleShoulder:
          if (descriptorValue != null) {
            setDescriptorValue<TackleShoulder>(
                TackleShoulder.values[descriptorValue]);
          }
          break;
        case Descriptors.turnover:
          if (descriptorValue != null) {
            setDescriptorValue<Turnover>(Turnover.values[descriptorValue]);
          }
          break;
        case Descriptors.infraction:
          if (descriptorValue != null) {
            setDescriptorValue<Infraction>(Infraction.values[descriptorValue]);
          }
          break;
        case Descriptors.cardStatus:
          if (descriptorValue != null) {
            setDescriptorValue<CardStatus>(CardStatus.values[descriptorValue]);
          }
          break;
        case Descriptors.kickType:
          if (descriptorValue != null) {
            setDescriptorValue<KickType>(KickType.values[descriptorValue]);
          }
          break;
        case Descriptors.goalKick:
          if (descriptorValue != null) {
            setDescriptorValue<GoalKick>(GoalKick.values[descriptorValue]);
          }
          break;
        case Descriptors.result:
          if (descriptorValue != null) {
            setDescriptorValue<Result>(Result.values[descriptorValue]);
          }
          break;
        case Descriptors.lineResult:
          if (descriptorValue != null) {
            setDescriptorValue<LineResult>(LineResult.values[descriptorValue]);
          }
          break;
        case Descriptors.lineQuantity:
          if (descriptorValue != null) {
            setDescriptorValue<LineQuantity>(
                LineQuantity.values[descriptorValue]);
          }
          break;
        case Descriptors.linePosition:
          if (descriptorValue != null) {
            setDescriptorValue<LinePosition>(
                LinePosition.values[descriptorValue]);
          }
          break;
        case Descriptors.points:
          if (descriptorValue != null) {
            setDescriptorValue<Points>(Points.values[descriptorValue]);
          }
          break;
        case Descriptors.breakType:
          if (descriptorValue != null) {
            setDescriptorValue<BreakType>(BreakType.values[descriptorValue]);
          }
          break;
        case Descriptors.speed:
          if (descriptorValue != null) {
            setDescriptorValue<Speed>(Speed.values[descriptorValue]);
          }
          break;
      }
      setDescriptorValue(element);
    });
  }

// save a simple csv to document directory
  String toCsv(int progressive, AppState appState) {
    // String restartTypeString = getDescriptorValue<RestartType>().toString().split('.').last;

    String eventRow0 = [
      progressive.toString(),
      timestamp.toIso8601String(),
      '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      duration.inSeconds, // duration in seconds
      name, //event name
      "${fieldPosition.dx} - ${fieldPosition.dy}", //field position
      appState.getTeam(teamType).name, // team name
      // getPlayers().values.first?.name ?? '-', //Player 1
      // getPlayers().values.elementAt(1)?.name ?? '-', // Player 2
      getPlayers().values.isNotEmpty
          ? getPlayers().values.first?.name ?? ' '
          : ' ', //Player 1
      getPlayers().values.length > 1
          ? getPlayers().values.elementAt(1)?.name ?? ' '
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
