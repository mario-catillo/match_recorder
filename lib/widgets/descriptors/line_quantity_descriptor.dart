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

  String _translateLineQuantity(LineQuantity lineQuantity) {
    switch (lineQuantity) {
      case LineQuantity.two:
        return "2";
      case LineQuantity.three:
        return "3";
      case LineQuantity.four:
        return "4";
      case LineQuantity.five:
        return "5";
      case LineQuantity.six:
        return "6";
      case LineQuantity.seven:
        return "7";
      case LineQuantity.other:
        return "Altro";
      default:
        return 'Quantità';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('LineQuantity: '),
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
                    onLineQuantityChanged(LineQuantity.values[selectedItem]);
                  },
                  children: List<Widget>.generate(LineQuantity.values.length,
                      (int index) {
                    return Center(
                      child: Text(
                        _translateLineQuantity(LineQuantity.values[index]),
                      ),
                    );
                  }),
                ),
                context),
            // This displays the selected fruit name.
            child: Text(
              _translateLineQuantity(LineQuantity
                      .values[LineQuantity.values.indexOf(lineQuantity)])
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
  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoSlidingSegmentedControl<LineQuantity>(
  //     children: LineQuantity.values.asMap().map(
  //         (e, lineQuantity) => MapEntry(lineQuantity, Text(lineQuantity.toString()))),
  //     onValueChanged: (LineQuantity? lineQuantity) {
  //       if (lineQuantity != null) {
  //         onLineQuantityChanged(lineQuantity);
  //       }
  //     },
  //     groupValue: lineQuantity,
  //   );
  // }
}
