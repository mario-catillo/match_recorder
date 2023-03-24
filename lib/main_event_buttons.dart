import 'package:flutter/material.dart';
import 'package:match_recorder/event_description_view.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/base_event.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:match_recorder/models/tackle_event.dart';
import 'package:match_recorder/models/lineout_event.dart';
import 'package:match_recorder/models/try_event.dart';
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
      crossAxisCount: 6,
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
          child: const Text('Break'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Pass'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Ruck'),
        ),
        MaterialButton(
          onPressed: () => null,
          child: const Text('Mised Tackle'),
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
          child: const Text('Scrum'),
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
      ],
    );
  }
}
