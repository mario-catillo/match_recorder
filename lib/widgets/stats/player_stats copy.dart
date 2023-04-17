import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:match_recorder/enums/descriptors.dart';
// import 'package:match_recorder/models/app_state.dart';
// import 'package:match_recorder/models/events/base_event.dart';
// import 'package:match_recorder/models/events/lineout_event.dart';
// import 'package:match_recorder/models/player.dart';
// import 'package:match_recorder/models/events/scrum_event.dart';
// import 'package:match_recorder/models/events/maul_event.dart';
// import 'package:match_recorder/team_page.dart';
// import 'package:match_recorder/models/team.dart';
// import 'package:match_recorder/widgets/descriptors/cardstatus_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/infraction_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/kick_type_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/progression_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/speed_descriptor.dart';
// import 'package:match_recorder/widgets/player_select.dart';
// import 'package:match_recorder/widgets/descriptors/line_result_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/line_position_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/line_quantity_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/turnover_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/result_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/breaktype_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/tackle_shoulder_descriptor.dart';
// import 'package:match_recorder/widgets/descriptors/goalkick_descriptor.dart';
// import 'package:match_recorder/widgets/players_select.dart';
// import 'package:match_recorder/widgets/descriptors/points_descriptor.dart';
// import 'package:match_recorder/widgets/rugby_field/rugby_field.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlayerStats extends StatelessWidget {
  final List<PlayerStatsData> data;

  PlayerStats(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar el gráfico de barras aquí
    return Container();
  }
}

class PlayerStatsData {
  final String playerName;
  final int tackles;
  final int advance;
  final charts.Color advanceColor;

  PlayerStatsData(
      {required this.playerName,
      required this.tackles,
      required this.advance,
      required this.advanceColor});
}

List<charts.Series<PlayerStatsData, String>> _createSeriesData() {
  return [
    charts.Series<PlayerStatsData, String>(
      id: 'Tackles',
      data: data,
      domainFn: (PlayerStatsData stats, _) => stats.playerName,
      measureFn: (PlayerStatsData stats, _) => stats.tackles,
    ),
    charts.Series<PlayerStatsData, String>(
      id: 'Advance',
      data: data,
      domainFn: (PlayerStatsData stats, _) => stats.playerName,
      measureFn: (PlayerStatsData stats, _) => stats.advance,
      colorFn: (PlayerStatsData stats, _) => stats.advanceColor,
    ),
  ];
}

List<PlayerStatsData> data = [
  PlayerStatsData(
      playerName: 'Jugador 1',
      tackles: 10,
      advance: 50,
      advanceColor: charts.MaterialPalette.green.shadeDefault),
  PlayerStatsData(
      playerName: 'Jugador 2',
      tackles: 8,
      advance: 60,
      advanceColor: charts.MaterialPalette.blue.shadeDefault),
  PlayerStatsData(
      playerName: 'Jugador 3',
      tackles: 12,
      advance: 40,
      advanceColor: charts.MaterialPalette.red.shadeDefault),
  PlayerStatsData(
      playerName: 'Jugador 4',
      tackles: 6,
      advance: 70,
      advanceColor: charts.MaterialPalette.deepOrange.shadeDefault),
  PlayerStatsData(
      playerName: 'Jugador 5',
      tackles: 14,
      advance: 30,
      advanceColor: charts.MaterialPalette.purple.shadeDefault),
];

@override
Widget build(BuildContext context) {
  return charts.BarChart(
    _createSeriesData(),
    animate: true,
    vertical: false,
    barRendererDecorator: charts.BarLabelDecorator<String>(),
    domainAxis: charts.OrdinalAxisSpec(
      renderSpec: charts.NoneRenderSpec(),
    ),
  );
}
