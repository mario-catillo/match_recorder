import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class LineResultnDescriptor extends StatelessWidget {
  final LineResult? lineResult;
  final Function(LineResult progress) onLineResultChanged;
  // final double _kItemExtent = 32.0;
  const LineResultnDescriptor(
      {Key? key, required this.lineResult, required this.onLineResultChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<LineResult?>(
      children: const {
        LineResult.clean: Text("Clean"),
        LineResult.dirty: Text("Dirty"),
        LineResult.lost: Text("Lost"),
        LineResult.notStraight: Text("Not straight"),
      },
      onValueChanged: (LineResult? lineResult) {
        if (lineResult != null) {
          onLineResultChanged(lineResult);
        }
      },
      groupValue: lineResult,
    );
  }
}
