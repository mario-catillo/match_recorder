import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/scrum_event.dart';
import 'package:match_recorder/team_page.dart';
import 'package:match_recorder/widgets/players_select.dart';
import 'package:match_recorder/widgets/rugby_field/rugby_field.dart';
import 'package:provider/provider.dart';

class EventDescriptionView extends StatefulWidget {
  final BaseEvent event;
  const EventDescriptionView({Key? key, required this.event}) : super(key: key);

  @override
  _EventDescriptionViewState createState() => _EventDescriptionViewState();
}

class _EventDescriptionViewState extends State<EventDescriptionView> {
  List<Player> selectedPlayers = [];
  late BaseEvent event;
  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  void _saveEvent() {
    event.players = selectedPlayers;
    context.read<AppState>().pushEvent(event);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Description'),
      ),
      body: Column(
        children: [
          Text(event.time),
          CupertinoSlidingSegmentedControl<TeamType>(
            children: const {
              TeamType.team1: Text('Team 1'),
              TeamType.team2: Text('Team 2'),
            },
            onValueChanged: (TeamType? team) {
              if (team != null) {
                setState(() {
                  event.teamType = team;
                });
              }
            },
            groupValue: event.teamType,
          ),
          Expanded(
              child: PlayersSelect(
            teamType: event.teamType,
            onPlayersChanged: (List<Player> players) =>
                selectedPlayers = players,
          )),
          if (event is ScrumEvent)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Team vincente:"),
                CupertinoSlidingSegmentedControl<TeamType>(
                  children: const {
                    TeamType.team1: Text('Team 1'),
                    TeamType.team2: Text('Team 2'),
                  },
                  onValueChanged: (TeamType? team) {
                    if (team != null) {
                      setState(() {
                        (event as ScrumEvent).winnerTeam = team;
                      });
                    }
                  },
                  groupValue: (event as ScrumEvent).winnerTeam,
                ),
              ],
            ),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints) => SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxWidth * 0.55,
                child: RugbyField(
                  onPositionClicked: (Offset offset) => {
                    event.fieldPosition = offset,
                  },
                  position: event.fieldPosition,
                )),
          ),
          ElevatedButton(
              onPressed: _saveEvent, child: const Text("Salva evento"))
        ],
      ),
    );
  }
}
