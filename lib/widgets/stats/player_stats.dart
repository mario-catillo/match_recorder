import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlayerData {
  final String name;
  final int appearances;
  final int positiveEvents;
  final int negativeEvents;
  final int neutralEvents;

  PlayerData({
    required this.name,
    required this.appearances,
    required this.positiveEvents,
    required this.negativeEvents,
    required this.neutralEvents,
  });
}

List<PlayerData> playerDataList = [
  PlayerData(
      name: 'Player 1',
      appearances: 5,
      positiveEvents: 4,
      negativeEvents: 1,
      neutralEvents: 0),
  PlayerData(
      name: 'Player 2',
      appearances: 5,
      positiveEvents: 0,
      negativeEvents: 4,
      neutralEvents: 1),
  PlayerData(
      name: 'Player 3',
      appearances: 3,
      positiveEvents: 1,
      negativeEvents: 0,
      neutralEvents: 2),
  // Add more players here
];

List<charts.Series<PlayerData, String>> seriesList = [
  charts.Series<PlayerData, String>(
    id: 'Positive',
    data: playerDataList,
    domainFn: (PlayerData data, _) => data.name,
    measureFn: (PlayerData data, _) => data.positiveEvents,
    colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
  ),
  charts.Series<PlayerData, String>(
    id: 'Negative',
    data: playerDataList,
    domainFn: (PlayerData data, _) => data.name,
    measureFn: (PlayerData data, _) => data.negativeEvents,
    colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
  ),
  charts.Series<PlayerData, String>(
    id: 'Neutral',
    data: playerDataList,
    domainFn: (PlayerData data, _) => data.name,
    measureFn: (PlayerData data, _) => data.neutralEvents,
    colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.yellow),
  )
];
