import 'dart:async';

import 'package:flutter/material.dart';
import 'package:match_recorder/models/stopwatch_state.dart';
import 'package:provider/provider.dart';

class MatchTimer extends StatelessWidget {
  const MatchTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final stopwatchState = Provider.of<StopwatchState>(context);
    return ValueListenableBuilder(
        valueListenable: stopwatchState.currentDuration,
        builder: (context, value, child) {
          return Text(
              "${value.inMinutes.toString().padLeft(2, '0')}:${(value.inSeconds % 60).toString().padLeft(2, '0')}");
        });
  }
}
