import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class BreakEnDescriptor extends StatelessWidget {
  final BreakType breaktype;
  final Function(BreakType breaktype) onBreakEChanged;
  const BreakEnDescriptor(
      {Key? key, required this.breaktype, required this.onBreakEChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<BreakType>(
      children: const {
        BreakType.individual: Text('Individual'),
        BreakType.kick: Text('Kick'),
        BreakType.numbers: Text('Numbers'),
        BreakType.sequence: Text('Sequence'),
      },
      onValueChanged: (BreakType? breaktype) {
        if (breaktype != null) {
          onBreakEChanged(breaktype);
        }
      },
      groupValue: breaktype,
    );
  }
}
