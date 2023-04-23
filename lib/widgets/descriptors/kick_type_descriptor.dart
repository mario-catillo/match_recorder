import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class KickTypeDescriptor extends StatelessWidget {
  final KickType? kickType;
  final Function(KickType kickType) onKickTypeChanged;
  final double _kItemExtent = 32.0;
  const KickTypeDescriptor(
      {Key? key, required this.kickType, required this.onKickTypeChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<KickType?>(
      children: const {
        KickType.upAndUnder: Text('Up & under'),
        KickType.box: Text('Box'),
        KickType.crossed: Text('Crossed'),
        KickType.drop: Text('Drop'),
        KickType.grubber: Text('Grubber'),
        KickType.punt: Text('Punt'),
        KickType.chip: Text('Chip'),
        KickType.touche: Text('Touche'),
        KickType.goal: Text('Goal'),
      },
      onValueChanged: (KickType? kickType) {
        if (kickType != null) {
          onKickTypeChanged(kickType);
        }
      },
      groupValue: kickType,
    );
  }
}
