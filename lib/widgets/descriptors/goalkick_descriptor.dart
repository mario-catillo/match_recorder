import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class GoalKickDescriptor extends StatelessWidget {
  final GoalKick goalKick;
  final Function(GoalKick goalKick) onGoalKickChanged;
  const GoalKickDescriptor(
      {Key? key, required this.goalKick, required this.onGoalKickChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<GoalKick>(
      children: const {
        GoalKick.good: Text('Good'),
        GoalKick.failed: Text('Failed'),
        // GoalKick.none: Text('None'),
      },
      onValueChanged: (GoalKick? goalKick) {
        if (goalKick != null) {
          onGoalKickChanged(goalKick);
        }
      },
      groupValue: goalKick,
    );
  }
}
