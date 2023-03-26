import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class LineResultnDescriptor extends StatelessWidget {
  final LineResult lineResult;
  final Function(LineResult progress) onLineResultChanged;
  final double _kItemExtent = 32.0;
  const LineResultnDescriptor(
      {Key? key, required this.lineResult, required this.onLineResultChanged})
      : super(key: key);

  String _translateLineResult(LineResult lineResult) {
    switch (lineResult) {
      case LineResult.clean:
        return "Pulita";
      case LineResult.dirty:
        return "Sporca";
      case LineResult.lost:
        return "Persa";
      case LineResult.notStraight:
        return "Storta";
      default:
        return 'Risultato';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('LineResult: '),
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
                    onLineResultChanged(LineResult.values[selectedItem]);
                  },
                  children: List<Widget>.generate(LineResult.values.length,
                      (int index) {
                    return Center(
                      child: Text(
                        _translateLineResult(LineResult.values[index]),
                      ),
                    );
                  }),
                ),
                context),
            // This displays the selected fruit name.
            child: Text(
              _translateLineResult(
                      LineResult.values[LineResult.values.indexOf(lineResult)])
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
  //   return CupertinoSlidingSegmentedControl<LineResult>(
  //     children: LineResult.values.asMap().map(
  //         (e, lineResult) => MapEntry(lineResult, Text(lineResult.toString()))),
  //     onValueChanged: (LineResult? lineResult) {
  //       if (lineResult != null) {
  //         onLineResultChanged(lineResult);
  //       }
  //     },
  //     groupValue: lineResult,
  //   );
  // }
}
