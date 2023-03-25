import 'package:flutter/material.dart';
import 'package:match_recorder/event_description_view.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/base_event.dart';
import 'package:match_recorder/models/scrum_event.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/models/tackle_event.dart';
import 'package:match_recorder/models/try_event.dart';
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
          child: const Text('Tackle'),
        ),
        MaterialButton(
          onPressed: () => _onEventPressed(context,
              TryEvent(time: context.read<StopwatchState>().currentTime.value)),
          child: const Text('Try'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Conversion'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Penalty'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Drop Goal'),
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
