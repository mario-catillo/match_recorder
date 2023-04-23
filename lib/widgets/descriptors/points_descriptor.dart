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
        Points.conversion2: Text('Trasformazione'),
        Points.drop3: Text('Drop'),
        Points.penalty3: Text('Calcio Pun.'),
        Points.try5: Text('Meta'),
        Points.penaltyTry7: Text('Meta tecnica'),
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
