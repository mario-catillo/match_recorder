import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/events/lineout_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/events/scrum_event.dart';
import 'package:match_recorder/team_page.dart';
import 'package:match_recorder/widgets/descriptors/cardstatus_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/infraction_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/kick_type_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/progression_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/speed_descriptor.dart';
import 'package:match_recorder/widgets/player_select.dart';
import 'package:match_recorder/widgets/descriptors/line_result_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/line_position_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/line_quantity_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/turnover_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/result_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/breaktype_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/tackle_shoulder_descriptor.dart';
import 'package:match_recorder/widgets/players_select.dart';
import 'package:match_recorder/widgets/descriptors/points_descriptor.dart';
import 'package:match_recorder/widgets/rugby_field/rugby_field.dart';
import 'package:provider/provider.dart';

class EventDescriptionView extends StatefulWidget {
  final BaseEvent event;
  const EventDescriptionView({Key? key, required this.event}) : super(key: key);

  @override
  _EventDescriptionViewState createState() => _EventDescriptionViewState();
}

class _EventDescriptionViewState extends State<EventDescriptionView> {
  late BaseEvent event;
  @override
  void initState() {
    event = widget.event;
    if (event is LineoutEvent) {
      (event as LineoutEvent)
          .setDefaultThrower(context.read<AppState>().defaultThrower);
      (event as LineoutEvent).setAppState(context.read<AppState>());
    }
    super.initState();
  }

  void _saveEvent() {
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
          Text(event.getTimeString()),
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
          for (var entry in event.getPlayers().entries)
            PlayerSelect(
                teamType: event.teamType,
                hintText: entry.key,
                selectedPlayer: event.getPlayer(entry.key),
                onPlayerChanged: (Player player) {
                  setState(() {
                    event.setPlayer(entry.key, player);
                  });
                }),
          // if (event is ScrumEvent)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Text("Team vincente:"),
          //       CupertinoSlidingSegmentedControl<TeamType>(
          //         children: const {
          //           TeamType.team1: Text('Team 1'),
          //           TeamType.team2: Text('Team 2'),
          //         },
          //         onValueChanged: (TeamType? team) {
          //           if (team != null) {
          //             setState(() {
          //               (event as ScrumEvent).winnerTeam = team;
          //             });
          //           }
          //         },
          //         groupValue: (event as ScrumEvent).winnerTeam,
          //       ),
          //     ],
          //   ),
          if (event.getDescriptors().contains(Descriptors.cardStatus))
            CardstatusDescriptor(
                cardStatus: event.getDescriptorValue<CardStatus>(),
                onCardStatusChanged: (CardStatus cardStatus) {
                  setState(() {
                    event.setDescriptorValue<CardStatus>(cardStatus);
                  });
                }),
          if (event.getDescriptors().contains(Descriptors.result))
            ResultnDescriptor(
                result: event.getDescriptorValue<Result>(),
                onResultChanged: (Result result) {
                  setState(() {
                    event.setDescriptorValue<Result>(result);
                  });
                }),
          if (event.getDescriptors().contains(Descriptors.movementProgression))
            ProgressionDescriptor(
                progress: event.getDescriptorValue<MovementProgression>(),
                onProgressChanged: (MovementProgression progress) {
                  setState(() {
                    event.setDescriptorValue<MovementProgression>(progress);
                  });
                }),
          if (event.getDescriptors().contains(Descriptors.lineQuantity))
            LineQuantitynDescriptor(
                lineQuantity: event.getDescriptorValue<LineQuantity>(),
                onLineQuantityChanged: (LineQuantity lineQuantity) {
                  setState(() {
                    event.setDescriptorValue<LineQuantity>(lineQuantity);
                  });
                }),
          if (event.getDescriptors().contains(Descriptors.linePosition))
            LinePositionnDescriptor(
                linePosition: event.getDescriptorValue<LinePosition>(),
                onLinePositionChanged: (LinePosition linePosition) {
                  setState(() {
                    event.setDescriptorValue<LinePosition>(linePosition);
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
          if (event.getDescriptors().contains(Descriptors.lineResult))
            LineResultnDescriptor(
              lineResult: event.getDescriptorValue<LineResult>(),
              onLineResultChanged: (LineResult lineResult) {
                setState(() {
                  event.setDescriptorValue<LineResult>(lineResult);
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
          if (event.getDescriptors().contains(Descriptors.points))
            PointsDescriptor(
              points: event.getDescriptorValue<Points>(),
              onPointsChanged: (Points points) {
                setState(() {
                  event.setDescriptorValue<Points>(points);
                });
              },
            ),
          if (event.getDescriptors().contains(Descriptors.turnover))
            TurnovernDescriptor(
                turnover: event.getDescriptorValue<Turnover>(),
                onTurnoverChanged: (Turnover turnover) {
                  setState(() {
                    event.setDescriptorValue<Turnover>(turnover);
                  });
                }),
          if (event.getDescriptors().contains(Descriptors.tackleShoulder))
            TackleShouldernDescriptor(
                tackleShoulder: event.getDescriptorValue<TackleShoulder>(),
                onTackleShoulderChanged: (TackleShoulder tackleShoulder) {
                  setState(() {
                    event.setDescriptorValue<TackleShoulder>(tackleShoulder);
                  });
                }),
          if (event.getDescriptors().contains(Descriptors.kickType))
            KickTypeDescriptor(
                kickType: event.getDescriptorValue<KickType>(),
                onKickTypeChanged: (KickType kickType) {
                  setState(() {
                    event.setDescriptorValue<KickType>(kickType);
                  });
                }),
          if (event.getDescriptors().contains(Descriptors.breakType))
            BreakEnDescriptor(
                breaktype: event.getDescriptorValue<BreakType>(),
                onBreakEChanged: (BreakType breaktype) {
                  setState(() {
                    event.setDescriptorValue<BreakType>(breaktype);
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
