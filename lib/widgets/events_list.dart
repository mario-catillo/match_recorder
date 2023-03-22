import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:provider/provider.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return ListView.builder(
      itemCount: appState.events.length,
      itemBuilder: (context, index) {
        return Text(appState.events[index].getEventName());
      },
    );
  }
}
