import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class CardstatusDescriptor extends StatelessWidget {
  final CardStatus? cardStatus;
  final Function(CardStatus cardStatus) onCardStatusChanged;
  const CardstatusDescriptor(
      {Key? key, required this.cardStatus, required this.onCardStatusChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<CardStatus?>(
      children: const {
        CardStatus.none: Text('No card'),
        CardStatus.yellow: Text('Yellow'),
        CardStatus.red: Text('Red'),
      },
      onValueChanged: (CardStatus? cardStatus) {
        if (cardStatus != null) {
          onCardStatusChanged(cardStatus);
        }
      },
      groupValue: cardStatus,
    );
  }
}
