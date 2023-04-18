import 'package:flutter/material.dart';
import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/event_description_view.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/events/infraction_event.dart';
import 'package:match_recorder/models/events/kick_event.dart';
import 'package:match_recorder/models/events/restart_event.dart';
import 'package:match_recorder/models/events/ruck_event.dart';
import 'package:match_recorder/models/events/scrum_event.dart';
import 'package:match_recorder/models/events/turnover_event.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/models/events/tackle_event.dart';
import 'package:match_recorder/models/events/lineout_event.dart';
import 'package:match_recorder/models/events/points_event.dart';
import 'package:match_recorder/models/events/missed_tackle_event.dart';
import 'package:match_recorder/models/events/break_event.dart';
import 'package:match_recorder/models/events/maul_event.dart';
import 'package:match_recorder/team_page.dart';
import 'package:match_recorder/widgets/event_button.dart';
import 'package:provider/provider.dart';

class MainEventButtons extends StatelessWidget {
  const MainEventButtons({
    super.key,
  });

  void _onEventPressed(BuildContext context, BaseEvent event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventDescriptionView(
                  event: event,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: [
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              RestartEvent(
                  duration:
                      context.read<StopwatchState>().currentDuration.value)),
          color: Colors.blue.shade400,
          child: const Text('Kick off / Restart'),
        ),
        EventButton(
          name: 'Tackle',
          buttoncolor: Colors.green.shade800,
          // icon: 'assets/icons/tackle.png',
          onPressed: () => _onEventPressed(
              context,
              TackleEvent(
                  duration:
                      context.read<StopwatchState>().currentDuration.value)),
        ),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              RuckEvent(
                  duration:
                      context.read<StopwatchState>().currentDuration.value)),
          color: Colors.blue.shade100,
          child: const Text('Ruck'),
        ),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              MissedTacklenEvent(
                  duration:
                      context.read<StopwatchState>().currentDuration.value)),
          color: Colors.red.shade300,
          child: const Text('Missed Tackle'),
        ),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              BreakEnEvent(
                  duration:
                      context.read<StopwatchState>().currentDuration.value)),
          color: Colors.green.shade600,
          child: const Text('Break'),
        ),
        EventButton(
            name: 'Kick',
            // icon: 'assets/icons/kick.png',
            onPressed: () => _onEventPressed(
                context,
                KickEvent(
                    duration:
                        context.read<StopwatchState>().currentDuration.value))),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              TurnoverEvent(
                  duration:
                      context.read<StopwatchState>().currentDuration.value)),
          color: Colors.orange.shade400,
          child: const Text('Turnover (lost)'),
        ),
        EventButton(
            name: 'Infraction',
            buttoncolor: Colors.red.shade600,
            // icon: 'assets/icons/referee.png',
            onPressed: () => _onEventPressed(
                context,
                InfractionEvent(
                    duration:
                        context.read<StopwatchState>().currentDuration.value))),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              LineoutEvent("5",
                  duration:
                      context.read<StopwatchState>().currentDuration.value)),
          color: Colors.blueAccent.shade400,
          child: const Text('Lineout'),
        ),
        EventButton(
            name: 'Maul',
            buttoncolor: Colors.lightBlue.shade400,
            onPressed: () => _onEventPressed(
                context,
                MaulEvent(
                    duration:
                        context.read<StopwatchState>().currentDuration.value))),
        EventButton(
          // icon: 'assets/icons/scrum.png',
          buttoncolor: Colors.blue.shade700,
          onPressed: () => _onEventPressed(
              context,
              ScrumEvent(
                duration: context.read<StopwatchState>().currentDuration.value,
              )),
          name: 'Scrum',
        ),
        EventButton(
            name: 'Points',
            buttoncolor: Colors.blue.shade800,
            // icon: 'assets/icons/try.png',
            onPressed: () => _onEventPressed(
                context,
                PointsEvent(
                    duration:
                        context.read<StopwatchState>().currentDuration.value))),
      ],
    );
  }
}
