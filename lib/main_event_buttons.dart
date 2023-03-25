import 'package:flutter/material.dart';
import 'package:match_recorder/event_description_view.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/events/infraction_event.dart';
import 'package:match_recorder/models/events/ruck_event.dart';
import 'package:match_recorder/models/events/scrum_event.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/models/events/tackle_event.dart';
import 'package:match_recorder/models/events/lineout_event.dart';
import 'package:match_recorder/models/events/try_event.dart';
import 'package:match_recorder/team_page.dart';
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
              TackleEvent(
                  time: context.read<StopwatchState>().currentTime.value)),
          child: Column(
            children: [
              Image.asset('assets/icons/tackle.png', width: 50, height: 50),
              const Text('Tackle'),
            ],
          ),
        ),
        MaterialButton(
          onPressed: () => _onEventPressed(context,
              TryEvent(time: context.read<StopwatchState>().currentTime.value)),
          child: const Text('Try'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Break'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Pass'),
        ),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              RuckEvent(
                  time: context.read<StopwatchState>().currentTime.value)),
          child: const Text('Ruck'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Maul'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Kick'),
        ),
        MaterialButton(
            onPressed: () => _onEventPressed(
                context,
                InfractionEvent(
                    time: context.read<StopwatchState>().currentTime.value)),
            child: const Text('Infraction')),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Kick Off'),
        ),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              LineoutEvent("5",
                  time: context.read<StopwatchState>().currentTime.value)),
          child: const Text('Lineout'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Free kick'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Penalty'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Goal kick'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Points'),
        ),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              ScrumEvent(
                  time: context.read<StopwatchState>().currentTime.value,
                  winnerTeam: TeamType.team1)),
          child: const Text('Scrum'),
        ),
      ],
    );
  }
}
