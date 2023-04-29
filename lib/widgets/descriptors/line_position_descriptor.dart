import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class LinePositionnDescriptor extends StatelessWidget {
  final LinePosition? linePosition;
  final Function(LinePosition linePosition) onLinePositionChanged;
  const LinePositionnDescriptor(
      {Key? key,
      required this.linePosition,
      required this.onLinePositionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<LinePosition?>(
      children: const {
        LinePosition.A: Text('1st'),
        LinePosition.D: Text('1st+'),
        LinePosition.B: Text('2nd'),
        LinePosition.E: Text('2nd+'),
        LinePosition.C: Text('3rd'),
        LinePosition.other: Text('Other'),
      },
      onValueChanged: (LinePosition? linePosition) {
        if (linePosition != null) {
          onLinePositionChanged(linePosition);
        }
      },
      groupValue: linePosition,
    );
  }
}
