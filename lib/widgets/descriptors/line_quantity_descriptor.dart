import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class LineQuantitynDescriptor extends StatelessWidget {
  final LineQuantity? lineQuantity;
  final Function(LineQuantity progress) onLineQuantityChanged;
  final double _kItemExtent = 32.0;
  const LineQuantitynDescriptor(
      {Key? key,
      required this.lineQuantity,
      required this.onLineQuantityChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<LineQuantity?>(
      children: const {
        LineQuantity.seven: Text("7"),
        LineQuantity.six: Text("6"),
        LineQuantity.five: Text("5"),
        LineQuantity.four: Text("4"),
        LineQuantity.three: Text("3"),
        LineQuantity.two: Text("2"),
        LineQuantity.other: Text("Other"),
      },
      onValueChanged: (LineQuantity? lineQuantity) {
        if (lineQuantity != null) {
          onLineQuantityChanged(lineQuantity);
        }
      },
      groupValue: lineQuantity,
    );
  }
}
