import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class ProgressionDescriptor extends StatelessWidget {
  final MovementProgression? progress;
  final Function(MovementProgression progress) onProgressChanged;
  const ProgressionDescriptor(
      {Key? key, required this.progress, required this.onProgressChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<MovementProgression?>(
      children: const {
        MovementProgression.negative: Text('Negativo'),
        MovementProgression.neutral: Text('Neutro'),
        MovementProgression.positive: Text('Positivo'),
      },
      onValueChanged: (MovementProgression? progress) {
        if (progress != null) {
          onProgressChanged(progress);
        }
      },
      groupValue: progress,
    );
  }
}
