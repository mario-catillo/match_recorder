import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class LineResultnDescriptor extends StatelessWidget {
  final LineResult lineResult;
  final Function(LineResult progress) onLineResultChanged;
  // final double _kItemExtent = 32.0;
  const LineResultnDescriptor(
      {Key? key, required this.lineResult, required this.onLineResultChanged})
      : super(key: key);

  // String _translateLineResult(LineResult lineResult) {
  //   switch (lineResult) {
  //     case LineResult.clean:
  //       return "Pulita";
  //     case LineResult.dirty:
  //       return "Sporca";
  //     case LineResult.lost:
  //       return "Persa";
  //     case LineResult.notStraight:
  //       return "Storta";
  //     default:
  //       return 'Risultato';
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<LineResult>(
      children: const {
        LineResult.clean: Text("Pulita"),
        LineResult.dirty: Text("Sporca"),
        LineResult.lost: Text("Persa"),
        LineResult.notStraight: Text("Storta"),
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
