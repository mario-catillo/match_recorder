import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class LinePositionnDescriptor extends StatelessWidget {
  final LinePosition linePosition;
  final Function(LinePosition linePosition) onLinePositionChanged;
  const LinePositionnDescriptor(
      {Key? key,
      required this.linePosition,
      required this.onLinePositionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<LinePosition>(
      children: const {
        LinePosition.A: Text('0-30'),
        LinePosition.D: Text('15,5'),
        LinePosition.B: Text('30-60'),
        LinePosition.E: Text('45,5'),
        LinePosition.C: Text('60-90'),
        LinePosition.other: Text('Altro'),
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
