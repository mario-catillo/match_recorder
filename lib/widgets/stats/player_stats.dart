import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:match_recorder/enums/descriptors.dart';

class PlayerDataTackles {
  final String name;
  final int appearances;
  final int positiveEvents;
  final int negativeEvents;
  final int neutralEvents;

  PlayerDataTackles({
    required this.name,
    required this.appearances,
    required this.positiveEvents,
    required this.negativeEvents,
    required this.neutralEvents,
  });
}

class PlayerDataInfractions {
  final String name;
  final int infractions;
  final int offside;
  final int ruckAttack;
  final int ruckDefense;

  PlayerDataInfractions({
    required this.name,
    required this.infractions,
    required this.offside,
    required this.ruckAttack,
    required this.ruckDefense,
  });
}

class TeamDataInfractions {
  final String name;
  final int infractions;
  final int offside;
  final int ruckAttack;
  final int ruckDefense;

  TeamDataInfractions({
    required this.name,
    required this.infractions,
    required this.offside,
    required this.ruckAttack,
    required this.ruckDefense,
  });
}

List<PlayerDataTackles> playerDataList = [
  PlayerDataTackles(
      name: 'Player 1',
      appearances: 5,
      positiveEvents: 4,
      negativeEvents: 1,
      neutralEvents: 0),
  PlayerDataTackles(
      name: 'Player 2',
      appearances: 5,
      positiveEvents: 0,
      negativeEvents: 4,
      neutralEvents: 1),
  PlayerDataTackles(
      name: 'Player 3',
      appearances: 3,
      positiveEvents: 1,
      negativeEvents: 0,
      neutralEvents: 2),
  // Add more players here
];

List<PlayerDataInfractions> playerDataList2 = [
  PlayerDataInfractions(
      name: 'Player 1',
      infractions: 8,
      offside: 4,
      ruckAttack: 1,
      ruckDefense: 3),
  PlayerDataInfractions(
      name: 'Player 2',
      infractions: 5,
      offside: 2,
      ruckAttack: 0,
      ruckDefense: 3),
  PlayerDataInfractions(
      name: 'Player 3',
      infractions: 3,
      offside: 1,
      ruckAttack: 1,
      ruckDefense: 1),
  // Add more players here
];

Map<String, double> teamInfractionsMap = {
  "offside": 8,
  "ruckAttack": 3,
  "ruckDefense": 2,
};

List<charts.Series<PlayerDataTackles, String>> seriesList = [
  charts.Series<PlayerDataTackles, String>(
      id: 'Positive',
      data: playerDataList,
      domainFn: (PlayerDataTackles data, _) => data.name,
      measureFn: (PlayerDataTackles data, _) => data.positiveEvents,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
      // labelAccessorFn: _getLabel,
      labelAccessorFn: (PlayerDataTackles data, _) {
        if (data.positiveEvents != 0) {
          return '${data.positiveEvents}';
        } else {
          return '';
        }
      }),
  charts.Series<PlayerDataTackles, String>(
      id: 'Negative',
      data: playerDataList,
      domainFn: (PlayerDataTackles data, _) => data.name,
      measureFn: (PlayerDataTackles data, _) => data.negativeEvents,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
      labelAccessorFn: (PlayerDataTackles data, _) {
        if (data.negativeEvents != 0) {
          return '${data.negativeEvents}';
        } else {
          return '';
        }
      }),
  charts.Series<PlayerDataTackles, String>(
      id: 'Neutral',
      data: playerDataList,
      domainFn: (PlayerDataTackles data, _) => data.name,
      measureFn: (PlayerDataTackles data, _) => data.neutralEvents,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.yellow),
      labelAccessorFn: (PlayerDataTackles data, _) {
        if (data.neutralEvents != 0) {
          return '${data.neutralEvents}';
        } else {
          return '';
        }
      }),
];

List<charts.Series<PlayerDataInfractions, String>> seriesList2 = [
  charts.Series<PlayerDataInfractions, String>(
      id: 'Offside',
      data: playerDataList2,
      domainFn: (PlayerDataInfractions data, _) => data.name,
      measureFn: (PlayerDataInfractions data, _) => data.offside,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
      labelAccessorFn: (PlayerDataInfractions data, _) {
        if (data.offside != 0) {
          return '${data.offside}';
        } else {
          return '';
        }
      }),
  charts.Series<PlayerDataInfractions, String>(
      id: 'Ruck Defense',
      data: playerDataList2,
      domainFn: (PlayerDataInfractions data, _) => data.name,
      measureFn: (PlayerDataInfractions data, _) => data.ruckAttack,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
      labelAccessorFn: (PlayerDataInfractions data, _) {
        if (data.ruckAttack != 0) {
          return '${data.ruckAttack}';
        } else {
          return '';
        }
      }),
  charts.Series<PlayerDataInfractions, String>(
      id: 'Ruck Attack',
      data: playerDataList2,
      domainFn: (PlayerDataInfractions data, _) => data.name,
      measureFn: (PlayerDataInfractions data, _) => data.ruckDefense,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.yellow),
      labelAccessorFn: (PlayerDataInfractions data, _) {
        if (data.ruckDefense != 0) {
          return '${data.ruckDefense}';
        } else {
          return '';
        }
      })
];
