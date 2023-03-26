// import 'package:flutter/cupertino.dart';
// import 'package:match_recorder/enums/descriptors.dart';

// class LinePositionnDescriptor extends StatelessWidget {
//   final LinePosition linePosition;
//   final Function(LinePosition progress) onLinePositionChanged;
//   final double _kItemExtent = 32.0;
//   const LinePositionnDescriptor(
//       {Key? key,
//       required this.linePosition,
//       required this.onLinePositionChanged})
//       : super(key: key);

//   String _translateLinePosition(LinePosition linePosition) {
//     switch (linePosition) {
//       case LinePosition.A:
//         return "0-30";
//       case LinePosition.B:
//         return "30-60";
//       case LinePosition.C:
//         return "60-90";
//       case LinePosition.D:
//         return "15,5";
//       case LinePosition.E:
//         return "45,5";
//       case LinePosition.other:
//         return "Altro";
//       default:
//         return 'Position';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text('LinePosition: '),
//           CupertinoButton(
//             padding: EdgeInsets.zero,
//             // Display a CupertinoPicker with list of fruits.
//             onPressed: () => _showDialog(
//                 CupertinoPicker(
//                   magnification: 1.22,
//                   squeeze: 1.2,
//                   useMagnifier: true,
//                   itemExtent: _kItemExtent,
//                   // This is called when selected item is changed.
//                   onSelectedItemChanged: (int selectedItem) {
//                     onLinePositionChanged(LinePosition.values[selectedItem]);
//                   },
//                   children: List<Widget>.generate(LinePosition.values.length,
//                       (int index) {
//                     return Center(
//                       child: Text(
//                         _translateLinePosition(LinePosition.values[index]),
//                       ),
//                     );
//                   }),
//                 ),
//                 context),
//             // This displays the selected fruit name.
//             child: Text(
//               _translateLinePosition(LinePosition
//                       .values[LinePosition.values.indexOf(linePosition)])
//                   .toString(),
//               style: const TextStyle(
//                 fontSize: 22.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
//   void _showDialog(Widget child, BuildContext context) {
//     showCupertinoModalPopup<void>(
//         context: context,
//         builder: (BuildContext context) => Container(
//               height: 216,
//               padding: const EdgeInsets.only(top: 6.0),
//               // The Bottom margin is provided to align the popup above the system navigation bar.
//               margin: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               // Provide a background color for the popup.
//               color: CupertinoColors.systemBackground.resolveFrom(context),
//               // Use a SafeArea widget to avoid system overlaps.
//               child: SafeArea(
//                 top: false,
//                 child: child,
//               ),
//             ));
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return CupertinoSlidingSegmentedControl<LinePosition>(
//   //     children: LinePosition.values.asMap().map(
//   //         (e, linePosition) => MapEntry(linePosition, Text(linePosition.toString()))),
//   //     onValueChanged: (LinePosition? linePosition) {
//   //       if (linePosition != null) {
//   //         onLinePositionChanged(linePosition);
//   //       }
//   //     },
//   //     groupValue: linePosition,
//   //   );
//   // }
// }
