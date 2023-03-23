import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/base_event.dart';
import 'package:match_recorder/team_page.dart';
import 'package:provider/provider.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return ListView.builder(
      itemCount: appState.events.length,
      itemBuilder: (context, index) {
        BaseEvent event = appState.events[index];
        return Container(
          color: event.teamType == TeamType.team1 ? Colors.green : Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(event.getEventName()), Text(event.time)],
          ),
        );
      },
    );
  }
}
