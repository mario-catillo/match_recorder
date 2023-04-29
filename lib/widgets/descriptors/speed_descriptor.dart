import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class SpeedDescriptor extends StatelessWidget {
  final Speed? speed;
  final Function(Speed speed) onSpeedChanged;
  const SpeedDescriptor(
      {Key? key, required this.speed, required this.onSpeedChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<Speed?>(
      children: const {
        Speed.slow: Text('Quick'),
        Speed.fast: Text('Slow'),
      },
      onValueChanged: (Speed? speed) {
        if (speed != null) {
          onSpeedChanged(speed);
        }
      },
      groupValue: speed,
    );
  }
}
