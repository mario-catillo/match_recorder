import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/events/scrum_event.dart';
import 'package:match_recorder/team_page.dart';
import 'package:match_recorder/widgets/descriptors/infraction_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/kick_type_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/progression_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/speed_descriptor.dart';
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
    event = widget.event;
    selectedPlayers = event.players;
    super.initState();
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
        title: Text("${event.getEventName()} description"),
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
            selectedPlayers: event.players,
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
          if (event.getDescriptors().contains(Descriptors.movementProgression))
            ProgressionDescriptor(
                progress: event.getDescriptorValue<MovementProgression>(),
                onProgressChanged: (MovementProgression progress) {
                  setState(() {
                    event.setDescriptorValue<MovementProgression>(progress);
                  });
                }),
          if (event.getDescriptors().contains(Descriptors.infraction))
            InfractionnDescriptor(
              infraction: event.getDescriptorValue<Infraction>(),
              onInfractionChanged: (Infraction infraction) {
                setState(() {
                  event.setDescriptorValue<Infraction>(infraction);
                });
              },
            ),
          if (event.getDescriptors().contains(Descriptors.speed))
            SpeedDescriptor(
              speed: event.getDescriptorValue<Speed>(),
              onSpeedChanged: (Speed speed) {
                setState(() {
                  event.setDescriptorValue<Speed>(speed);
                });
              },
            ),
          if (event.getDescriptors().contains(Descriptors.kickType))
            KickTypeDescriptor(
                kickType: event.getDescriptorValue<KickType>(),
                onKickTypeChanged: (KickType kickType) {
                  setState(() {
                    event.setDescriptorValue<KickType>(kickType);
                  });
                }),
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
