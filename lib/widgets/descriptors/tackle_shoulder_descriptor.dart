import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class TackleShouldernDescriptor extends StatelessWidget {
  final TackleShoulder? tackleShoulder;
  final Function(TackleShoulder tackleShoulder) onTackleShoulderChanged;
  const TackleShouldernDescriptor(
      {Key? key,
      required this.tackleShoulder,
      required this.onTackleShoulderChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<TackleShoulder?>(
      children: const {
        TackleShoulder.internal: Text('Inside'),
        TackleShoulder.external: Text('Outside'),
        TackleShoulder.double: Text('Double'),
      },
      onValueChanged: (TackleShoulder? tackleShoulder) {
        if (tackleShoulder != null) {
          onTackleShoulderChanged(tackleShoulder);
        }
      },
      groupValue: tackleShoulder,
    );
  }
}
