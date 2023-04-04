import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class ResultnDescriptor extends StatelessWidget {
  final Result result;
  final Function(Result progress) onResultChanged;
  const ResultnDescriptor(
      {Key? key, required this.result, required this.onResultChanged})
      : super(key: key);

  // String _translateResult(Result result) {
  //   switch (result) {
  //     case Result.won:
  //       return "Vinta";
  //     case Result.lost:
  //       return "Persa";
  //     default:
  //       return 'Risultato';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<Result>(
      children: const {
        Result.won: Text("Vinta"),
        Result.lost: Text("Persa"),
      },
      onValueChanged: (Result? result) {
        if (result != null) {
          onResultChanged(result);
        }
      },
      groupValue: result,
    );
  }
}
