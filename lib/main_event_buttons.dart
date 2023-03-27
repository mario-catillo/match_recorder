import 'package:flutter/material.dart';
import 'package:match_recorder/event_description_view.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/events/infraction_event.dart';
import 'package:match_recorder/models/events/kick_event.dart';
import 'package:match_recorder/models/events/ruck_event.dart';
import 'package:match_recorder/models/events/scrum_event.dart';
import 'package:match_recorder/models/events/turnover_event.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/models/events/tackle_event.dart';
import 'package:match_recorder/models/events/lineout_event.dart';
import 'package:match_recorder/models/events/points_event.dart';
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
        EventButton(
          name: 'Tackle',
          icon: 'assets/icons/tackle.png',
          onPressed: () => _onEventPressed(
              context,
              TackleEvent(
                  time: context.read<StopwatchState>().currentTime.value)),
        ),
        EventButton(
            name: 'Points',
            icon: 'assets/icons/try.png',
            onPressed: () => _onEventPressed(
                context,
                PointsEvent(
                    time: context.read<StopwatchState>().currentTime.value))),
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
        EventButton(
            name: 'Kick',
            icon: 'assets/icons/kick.png',
            onPressed: () => _onEventPressed(
                context,
                KickEvent(
                    time: context.read<StopwatchState>().currentTime.value))),
        EventButton(
            name: 'Infraction',
            icon: 'assets/icons/referee.png',
            onPressed: () => _onEventPressed(
                context,
                InfractionEvent(
                    time: context.read<StopwatchState>().currentTime.value))),
        MaterialButton(
          onPressed: () => _onEventPressed(
              context,
              LineoutEvent("5",
                  time: context.read<StopwatchState>().currentTime.value)),
          child: const Text('Lineout'),
        ),
        EventButton(
          icon: 'assets/icons/scrum.png',
          onPressed: () => _onEventPressed(
              context,
              ScrumEvent(
                  time: context.read<StopwatchState>().currentTime.value,
                  winnerTeam: TeamType.team1)),
          name: 'Scrum',
        ),
        EventButton(
          onPressed: () => _onEventPressed(
              context,
              TurnoverEvent(
                time: context.read<StopwatchState>().currentTime.value,
              )),
          name: 'Turnover',
        ),
      ],
    );
  }
}
