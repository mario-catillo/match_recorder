import 'package:flutter/material.dart';
import 'package:match_recorder/main_event_buttons.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/team_page.dart';
import 'package:match_recorder/widgets/YellowCardPlayer.dart';
import 'package:match_recorder/widgets/events_list.dart';
import 'package:match_recorder/widgets/game_phase_switch.dart';
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
        backgroundColor: Colors.grey,

        title: Text("test"),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //create an appbar bottom to contain the stopwatchBar widget
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70), child: StopwatchBar()),
      ),
      //a custom bottom navigation bar to contain the game phase switch and the match timer

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
      body: MainEventButtons(),
    );
  }
}

class StopwatchBar extends StatelessWidget {
  const StopwatchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<StopwatchState>(builder: (ctx, stopwatchState, child) {
        return SizedBox(
          height: 90,
          child: Column(
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
                      gameStatus: GameStatus.nullTime,
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
                  if (stopwatchState.currentDuration.value != Duration.zero)
                    IconButton(
                        onPressed: () {
                          stopwatchState.reset();
                        },
                        icon: const Icon(Icons.refresh)),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
