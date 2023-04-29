import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/events/lineout_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/events/scrum_event.dart';
import 'package:match_recorder/models/events/maul_event.dart';
import 'package:match_recorder/team_page.dart';
import 'package:match_recorder/models/team.dart';
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
import 'package:match_recorder/widgets/descriptors/restart_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/breaktype_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/tackle_shoulder_descriptor.dart';
import 'package:match_recorder/widgets/descriptors/goalkick_descriptor.dart';
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
    Team team = context.read<AppState>().getTeam(event.teamType);
    return Scaffold(
        appBar: AppBar(
          title: Text("${event.getEventName()} description"),
          actions: [
            IconButton(onPressed: _saveEvent, icon: const Icon(Icons.save))
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/grass-275986_1280.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              // padding: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(
                  top: 10, left: 20, bottom: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: OrientationBuilder(
                builder: (BuildContext ctx, Orientation orientation) {
                  return Flex(
                    direction: orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                    children: [
                      Expanded(
                        child: Column(
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
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.cardStatus))
                              CardstatusDescriptor(
                                  cardStatus:
                                      event.getDescriptorValue<CardStatus>(),
                                  onCardStatusChanged: (CardStatus cardStatus) {
                                    setState(() {
                                      event.setDescriptorValue<CardStatus>(
                                          cardStatus);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.result))
                              ResultnDescriptor(
                                  result: event.getDescriptorValue<Result>(),
                                  onResultChanged: (Result result) {
                                    setState(() {
                                      event.setDescriptorValue<Result>(result);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.restartType))
                              RestartTypenDescriptor(
                                  restartType:
                                      event.getDescriptorValue<RestartType>(),
                                  onrestartTypeChanged:
                                      (RestartType restartType) {
                                    setState(() {
                                      event.setDescriptorValue<RestartType>(
                                          restartType);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.movementProgression))
                              ProgressionDescriptor(
                                  progress: event.getDescriptorValue<
                                      MovementProgression>(),
                                  onProgressChanged:
                                      (MovementProgression progress) {
                                    setState(() {
                                      event.setDescriptorValue<
                                          MovementProgression>(progress);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.lineQuantity))
                              LineQuantitynDescriptor(
                                  lineQuantity:
                                      event.getDescriptorValue<LineQuantity>(),
                                  onLineQuantityChanged:
                                      (LineQuantity lineQuantity) {
                                    setState(() {
                                      event.setDescriptorValue<LineQuantity>(
                                          lineQuantity);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.linePosition))
                              LinePositionnDescriptor(
                                  linePosition:
                                      event.getDescriptorValue<LinePosition>(),
                                  onLinePositionChanged:
                                      (LinePosition linePosition) {
                                    setState(() {
                                      event.setDescriptorValue<LinePosition>(
                                          linePosition);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.infraction))
                              InfractionnDescriptor(
                                infraction:
                                    event.getDescriptorValue<Infraction>(),
                                onInfractionChanged: (Infraction infraction) {
                                  setState(() {
                                    event.setDescriptorValue<Infraction>(
                                        infraction);
                                  });
                                },
                              ),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.lineResult))
                              LineResultnDescriptor(
                                lineResult:
                                    event.getDescriptorValue<LineResult>(),
                                onLineResultChanged: (LineResult lineResult) {
                                  setState(() {
                                    event.setDescriptorValue<LineResult>(
                                        lineResult);
                                  });
                                },
                              ),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.speed))
                              SpeedDescriptor(
                                speed: event.getDescriptorValue<Speed>(),
                                onSpeedChanged: (Speed speed) {
                                  setState(() {
                                    event.setDescriptorValue<Speed>(speed);
                                  });
                                },
                              ),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.points))
                              PointsDescriptor(
                                points: event.getDescriptorValue<Points>(),
                                onPointsChanged: (Points points) {
                                  setState(() {
                                    event.setDescriptorValue<Points>(points);
                                  });
                                },
                              ),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.turnover))
                              TurnovernDescriptor(
                                  turnover:
                                      event.getDescriptorValue<Turnover>(),
                                  onTurnoverChanged: (Turnover turnover) {
                                    setState(() {
                                      event.setDescriptorValue<Turnover>(
                                          turnover);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.tackleShoulder))
                              TackleShouldernDescriptor(
                                  tackleShoulder: event
                                      .getDescriptorValue<TackleShoulder>(),
                                  onTackleShoulderChanged:
                                      (TackleShoulder tackleShoulder) {
                                    setState(() {
                                      event.setDescriptorValue<TackleShoulder>(
                                          tackleShoulder);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.kickType))
                              KickTypeDescriptor(
                                  kickType:
                                      event.getDescriptorValue<KickType>(),
                                  onKickTypeChanged: (KickType kickType) {
                                    setState(() {
                                      event.setDescriptorValue<KickType>(
                                          kickType);
                                    });
                                  }),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.goalKick))
                              if (event.getDescriptorValue<KickType>() ==
                                  KickType.goal)
                                GoalKickDescriptor(
                                  goalKick:
                                      event.getDescriptorValue<GoalKick>(),
                                  onGoalKickChanged: (GoalKick goalKick) {
                                    setState(() {
                                      event.setDescriptorValue<GoalKick>(
                                          goalKick);
                                    });
                                  },
                                ),
                            if (event
                                .getDescriptors()
                                .contains(Descriptors.breakType))
                              BreakEnDescriptor(
                                  breaktype:
                                      event.getDescriptorValue<BreakType>(),
                                  onBreakEChanged: (BreakType breaktype) {
                                    setState(() {
                                      event.setDescriptorValue<BreakType>(
                                          breaktype);
                                    });
                                  }),
                            // LayoutBuilder(
                            //   builder: (BuildContext ctx, BoxConstraints constraints) =>
                            //       SizedBox(
                            //           width: constraints.maxWidth,
                            //           height: constraints.maxWidth * 0.55,
                            //           child: RugbyField(
                            //             onPositionClicked: (Offset offset) => {
                            //               event.fieldPosition = offset,
                            //             },
                            //             position: event.fieldPosition,
                            //           )),
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: MultiPlayerSelectWidget(
                          event: event,
                          team: team,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )));
  }
}

class MultiPlayerSelectWidget extends StatefulWidget {
  final BaseEvent event;
  final Team team;

  const MultiPlayerSelectWidget(
      {Key? key, required this.event, required this.team})
      : super(key: key);

  @override
  State<MultiPlayerSelectWidget> createState() =>
      _MultiPlayerSelectWidgetState();
}

class _MultiPlayerSelectWidgetState extends State<MultiPlayerSelectWidget> {
  late String selectedPlayerKey;

  // @override
  // void initState() {
  //   selectedPlayerKey = widget.event.getPlayers().keys.first;
  //   super.initState();
  // }

  @override
  void initState() {
    if (widget.event.getPlayers() != null &&
        widget.event.getPlayers().isNotEmpty) {
      selectedPlayerKey = widget.event.getPlayers().keys.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Player> alreadySelectedPlayers = widget.event
        .getPlayers()
        .values
        .toList()
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
    return Column(
      children: [
        if (widget.event.getPlayers().keys.length > 1)
          CupertinoSlidingSegmentedControl<String>(
            children: Map.fromEntries(widget.event
                .getPlayers()
                .keys
                .map((e) => MapEntry(e, Text(e)))),
            groupValue: selectedPlayerKey,
            onValueChanged: (value) => setState(() {
              selectedPlayerKey = value!;
            }),
          ),
        Column(
          children: [
            for (var entry in widget.event.getPlayers().entries)
              if (selectedPlayerKey == entry.key)
                LayoutBuilder(
                  builder: (BuildContext ctx, BoxConstraints constraints) =>
                      widget.team.players.isEmpty
                          ? Text("No players")
                          : SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth * 0.55,
                              child: PlayerSelect(
                                alreadySelectedPlayers: alreadySelectedPlayers,
                                selectedPlayer: entry.value,
                                players: widget.team.players,
                                onPlayerTap: (player) {
                                  setState(() {
                                    widget.event.setPlayer(entry.key, player);
                                  });
                                },
                              )),
                ),
          ],
        ),
      ],
    );
  }
}
