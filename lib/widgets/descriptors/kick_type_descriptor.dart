import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class KickTypeDescriptor extends StatelessWidget {
  final KickType kickType;
  final Function(KickType kickType) onKickTypeChanged;
  final double _kItemExtent = 32.0;
  const KickTypeDescriptor(
      {Key? key, required this.kickType, required this.onKickTypeChanged})
      : super(key: key);

  String _translateKickType(KickType kickType) {
    switch (kickType) {
      case KickType.upAndUnder:
        return 'Up & Under';
      case KickType.box:
        return 'Box';
      case KickType.crossKick:
        return 'Cross Kick';
      case KickType.punt:
        return 'Punt';
      case KickType.drop:
        return 'Drop';
      case KickType.grubber:
        return 'Grubber';
      case KickType.chip:
        return 'Chip';
      case KickType.touche:
        return 'Touche';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('KickType: '),
          CupertinoButton(
            padding: EdgeInsets.zero,
            // Display a CupertinoPicker with list of fruits.
            onPressed: () => _showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: _kItemExtent,
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    onKickTypeChanged(KickType.values[selectedItem]);
                  },
                  children: List<Widget>.generate(KickType.values.length,
                      (int index) {
                    return Center(
                      child: Text(
                        _translateKickType(KickType.values[index]),
                      ),
                    );
                  }),
                ),
                context),
            // This displays the selected fruit name.
            child: Text(
              _translateKickType(
                      KickType.values[KickType.values.indexOf(kickType)])
                  .toString(),
              style: const TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }
}
