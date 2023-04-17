import 'package:flutter/material.dart';
import 'package:match_recorder/main_event_buttons.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/team_page.dart';
import 'package:match_recorder/widgets/YellowCardPlayer.dart';
import 'package:match_recorder/widgets/events_list.dart';
import 'package:match_recorder/widgets/match_timer.dart';
import 'package:match_recorder/widgets/misc/value_listenable_builder2.dart';
import 'package:match_recorder/widgets/saves/load_match_dialog.dart';
import 'package:match_recorder/widgets/saves/save_match_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:match_recorder/widgets/stats/player_stats.dart';
import 'package:match_recorder/team_stats_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ChangeNotifierProvider(create: (_) => StopwatchState())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Text('Match Recorder'),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => const SaveMatchDialog()),
                      child: const Text('Salva partita'),
                    ),
                    TextButton(
                        onPressed: () => showDialog(
                              context: context,
                              builder: (ctx) => const LoadMatchDialog(),
                            ),
                        child: const Text("Carica partita"))
                  ],
                )
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TeamPage(
                                  teamType: TeamType.team1,
                                ))),
                    child: Text("Team 1")),
                SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TeamPage(
                                  teamType: TeamType.team2,
                                ))),
                    child: Text("Team 2")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeamStatsPage(
                                // teamType2: TeamType.team1,
                                ))),
                    child: Text("Team 1 Stats")),
                SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeamStatsPage(
                                // teamType2: TeamType.team2,
                                ))),
                    child: Text("Team 2 Stats")),
              ],
            ),
            Expanded(child: EventsList()),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: MainEventButtons()),
            Consumer<AppState>(builder: (ctx, appState, child) {
              return Expanded(
                  child: ListView.builder(
                itemBuilder: (ctx, index) {
                  final player =
                      appState.yellowCardPlayers.entries.toList()[index].key;
                  final infractionTime = appState.yellowCardPlayers[player]!;
                  return YellowCardPlayer(
                      player: player, infractionTime: infractionTime);
                },
                itemCount: appState.yellowCardPlayers.entries.length,
              ));
            }),
            SafeArea(
              child: Consumer<StopwatchState>(
                  builder: (ctx, stopwatchState, child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GamePhaseSwitch(
                            gameStatus: GameStatus.defense,
                            stopwatchState: stopwatchState,
                          ),
                        ),
                        Expanded(
                          child: GamePhaseSwitch(
                            gameStatus: GameStatus.attack,
                            stopwatchState: stopwatchState,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () => stopwatchState.isRunning()
                                ? context.read<StopwatchState>().stop()
                                : context.read<StopwatchState>().start(),
                            icon: stopwatchState.isRunning()
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow)),
                        const MatchTimer(),
                        if (stopwatchState.currentDuration.value !=
                            Duration.zero)
                          IconButton(
                              onPressed: () {
                                stopwatchState.reset();
                              },
                              icon: const Icon(Icons.refresh)),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class GamePhaseSwitch extends StatelessWidget {
  final StopwatchState stopwatchState;
  final GameStatus gameStatus;
  const GamePhaseSwitch({
    super.key,
    required this.stopwatchState,
    required this.gameStatus,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => gameStatus == GameStatus.attack
          ? stopwatchState.setAttackTime()
          : stopwatchState.setDefenseTime(),
      child: Consumer<AppState>(builder: (ctx, appState, _) {
        return Container(
            color: stopwatchState.gameStatus == gameStatus
                ? gameStatus == GameStatus.defense
                    ? Colors.red
                    : Colors.green
                : Colors.grey[800],
            child: Column(children: [
              Text(gameStatus == GameStatus.attack ? "Attacco" : "Difesa"),
              ValueListenableBuilder2(
                  first: gameStatus == GameStatus.attack
                      ? stopwatchState.attackTime
                      : stopwatchState.defenseTime,
                  second: stopwatchState.currentDuration,
                  builder: (ctx, time, duration, child) {
                    double percentage =
                        ((time.inSeconds / duration.inSeconds) * 100);
                    if (percentage.isNaN) {
                      percentage = 0;
                    }
                    percentage = percentage.roundToDouble();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            " ${time.inMinutes.toString().padLeft(2, '0')}:${(time.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w200)),
                        const SizedBox(width: 10),
                        Text(
                          "$percentage%",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  })
            ]));
      }),
    );
  }
}
