import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class TurnovernDescriptor extends StatelessWidget {
  final Turnover? turnover;
  final Function(Turnover turnover) onTurnoverChanged;
  const TurnovernDescriptor(
      {Key? key, required this.turnover, required this.onTurnoverChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<Turnover?>(
      children: const {
        Turnover.blocked: Text('Blocked'),
        Turnover.jackal: Text('Jackal'),
        Turnover.kick: Text('Kick'),
        Turnover.knockOn: Text('Knock on'),
        Turnover.robbed: Text('Robbed'),
        Turnover.touch: Text('Touch'),
      },
      onValueChanged: (Turnover? turnover) {
        if (turnover != null) {
          onTurnoverChanged(turnover);
        }
      },
      groupValue: turnover,
    );
  }
}
