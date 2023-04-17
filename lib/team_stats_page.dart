import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/widgets/teams/team_open_dialog.dart';
import 'package:match_recorder/widgets/teams/team_save_dialog.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:match_recorder/widgets/stats/player_stats.dart';
import 'package:pie_chart/pie_chart.dart';

// enum TeamType { team1, team2 }

class TeamStatsPage extends StatelessWidget {
  // final TeamType teamType2;
  // const TeamStatsPage({Key? key, required this.teamType2}) : super(key: key);

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
              height: 200,
              child: charts.BarChart(
                seriesList,
                animate: false,
                vertical: true,
                barGroupingType: charts.BarGroupingType.stacked,
                barRendererDecorator: charts.BarLabelDecorator(
                    labelAnchor: charts.BarLabelAnchor.middle,
                    labelPosition: charts.BarLabelPosition.inside),
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelRotation: 60,
                  ),
                ),
                primaryMeasureAxis: charts.NumericAxisSpec(
                    renderSpec: charts.GridlineRendererSpec(
                        // labelStyle: charts.TextStyleSpec(
                        //     fontSize: 12,
                        //     color: charts.MaterialPalette.gray.shadeDefault),
                        // lineStyle: charts.LineStyleSpec(
                        //     color: charts.MaterialPalette.gray.shade100),
                        )),
                // primaryMeasureAxis: charts.NumericAxisSpec(),
                behaviors: [
                  new charts.ChartTitle('Tackles by player',
                      // subTitle: 'Top sub-title text',
                      behaviorPosition: charts.BehaviorPosition.top,
                      titleOutsideJustification:
                          charts.OutsideJustification.start,
                      innerPadding: 18),
                ],
              ),
            ),
            Container(
              height: 200,
              child: charts.BarChart(
                seriesList2,
                animate: false,
                vertical: true,
                barGroupingType: charts.BarGroupingType.stacked,
                barRendererDecorator: charts.BarLabelDecorator(
                    labelAnchor: charts.BarLabelAnchor.middle,
                    labelPosition: charts.BarLabelPosition.inside),
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
                ),
                // primaryMeasureAxis: charts.NumericAxisSpec(),
                behaviors: [
                  new charts.ChartTitle('Infractions by player',
                      // subTitle: 'Top sub-title text',
                      behaviorPosition: charts.BehaviorPosition.top,
                      titleOutsideJustification:
                          charts.OutsideJustification.start,
                      innerPadding: 18),
                ],
              ),
            ),
            Container(
                height: 200,
                child: PieChart(
                  dataMap: teamInfractionsMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  // colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.disc,
                  ringStrokeWidth: 32,
                  centerText: "Team Infractions",
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    // legendShape: _BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                  // gradientList: ---To add gradient colors---
                  // emptyColorGradient: ---Empty Color gradient---
                )),
          ],
        ),
      ),
    );
  }
}
