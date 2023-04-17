import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/widgets/teams/team_open_dialog.dart';
import 'package:match_recorder/widgets/teams/team_save_dialog.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:match_recorder/widgets/stats/player_stats.dart';
// import 'package:match_recorder/widgets/stats/chartTitle.dart';

// enum TeamType { team1, team2 }

class TeamStatsPage extends StatelessWidget {
  // final TeamType teamType2;
  // const TeamStatsPage({Key? key, required this.teamType2}) : super(key: key);

  final chartTitle = charts.ChartTitle('My Chart Title',
      behaviorPosition: charts.BehaviorPosition.top,
      titleOutsideJustification: charts.OutsideJustification.middleDrawArea);

  @override
  Widget build(BuildContext context) {
    // final team = context.read<AppState>().getTeam(teamType2);
    return Scaffold(
      appBar: AppBar(
        // title: Text("Tackles"),
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              child: charts.BarChart(
                seriesList,
                animate: true,
                vertical: true,
                behaviors: [chartTitle],
                barGroupingType: charts.BarGroupingType.stacked,
                domainAxis: charts.OrdinalAxisSpec(
                    renderSpec:
                        charts.SmallTickRendererSpec(labelRotation: 60)),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                        fontSize: 12,
                        color: charts.MaterialPalette.gray.shadeDefault),
                    lineStyle: charts.LineStyleSpec(
                        color: charts.MaterialPalette.gray.shade100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
