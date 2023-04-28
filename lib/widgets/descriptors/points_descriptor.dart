import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class PointsDescriptor extends StatelessWidget {
  final Points? points;
  final Function(Points points) onPointsChanged;
  const PointsDescriptor(
      {Key? key, required this.points, required this.onPointsChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<Points?>(
      children: const {
        Points.conversion2: Text('Conversion'),
        Points.drop3: Text('Drop'),
        Points.penalty3: Text('Penalty kick'),
        Points.try5: Text('Try'),
        Points.penaltyTry7: Text('Penalty try'),
      },
      onValueChanged: (Points? points) {
        if (points != null) {
          onPointsChanged(points);
        }
      },
      groupValue: points,
    );
  }
}
