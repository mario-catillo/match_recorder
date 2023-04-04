import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class LineQuantitynDescriptor extends StatelessWidget {
  final LineQuantity lineQuantity;
  final Function(LineQuantity progress) onLineQuantityChanged;
  final double _kItemExtent = 32.0;
  const LineQuantitynDescriptor(
      {Key? key,
      required this.lineQuantity,
      required this.onLineQuantityChanged})
      : super(key: key);

  // String _translateLineQuantity(LineQuantity lineQuantity) {
  //   switch (lineQuantity) {
  //     case LineQuantity.two:
  //       return "2";
  //     case LineQuantity.three:
  //       return "3";
  //     case LineQuantity.four:
  //       return "4";
  //     case LineQuantity.five:
  //       return "5";
  //     case LineQuantity.six:
  //       return "6";
  //     case LineQuantity.seven:
  //       return "7";
  //     case LineQuantity.other:
  //       return "Altro";
  //     default:
  //       return 'Quantità';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<LineQuantity>(
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
