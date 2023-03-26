import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class ResultnDescriptor extends StatelessWidget {
  final Result result;
  final Function(Result progress) onResultChanged;
  final double _kItemExtent = 32.0;
  const ResultnDescriptor(
      {Key? key, required this.result, required this.onResultChanged})
      : super(key: key);

  String _translateResult(Result result) {
    switch (result) {
      case Result.won:
        return "Vinta";
      case Result.lost:
        return "Persa";
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
          const Text('Result: '),
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
                    onResultChanged(Result.values[selectedItem]);
                  },
                  children:
                      List<Widget>.generate(Result.values.length, (int index) {
                    return Center(
                      child: Text(
                        _translateResult(Result.values[index]),
                      ),
                    );
                  }),
                ),
                context),
            // This displays the selected fruit name.
            child: Text(
              _translateResult(Result.values[Result.values.indexOf(result)])
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
  //   return CupertinoSlidingSegmentedControl<Result>(
  //     children: Result.values.asMap().map(
  //         (e, result) => MapEntry(result, Text(result.toString()))),
  //     onValueChanged: (Result? result) {
  //       if (result != null) {
  //         onResultChanged(result);
  //       }
  //     },
  //     groupValue: result,
  //   );
  // }
}
