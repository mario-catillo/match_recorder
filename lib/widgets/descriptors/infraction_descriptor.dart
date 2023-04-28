import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class InfractionnDescriptor extends StatelessWidget {
  final Infraction? infraction;
  final Function(Infraction progress) onInfractionChanged;
  // final double _kItemExtent = 32.0;
  const InfractionnDescriptor(
      {Key? key, required this.infraction, required this.onInfractionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<Infraction?>(
      children: const {
        Infraction.dirtyPlay: Text('Foul play'),
        Infraction.ruckAttack: Text('Ruck attack'),
        Infraction.ruckDefence: Text('Ruck defence'),
        Infraction.maul: Text('Maul'),
        Infraction.scrum: Text('Scrum'),
        Infraction.offside: Text('Offside'),
        Infraction.lineout: Text('Line-out'),
        Infraction.tenMeters: Text('+10'),
      },
      onValueChanged: (Infraction? infraction) {
        if (infraction != null) {
          onInfractionChanged(infraction);
        }
      },
      groupValue: infraction,
    );
  }
}




  // String _translateInfraction(Infraction infraction) {
  //   switch (infraction) {
  //     case Infraction.dirtyPlay:
  //       return "Gioco Sporco";
  //     case Infraction.ruckAttack:
  //       return "Ruck Attaco";
  //     case Infraction.ruckDefence:
  //       return "Ruck Difesa";
  //     case Infraction.maul:
  //       return "Maul";
  //     case Infraction.scrum:
  //       return "Mischia chiusa";
  //     case Infraction.offside:
  //       return "Fuori gioco";
  //     case Infraction.lineout:
  //       return "Touche";
  //     case Infraction.tenMeters:
  //       return "+10 metri";
  //     default:
  //       return 'Fallo';
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         const Text('Infraction: '),
  //         CupertinoButton(
  //           padding: EdgeInsets.zero,
  //           // Display a CupertinoPicker with list of fruits.
  //           onPressed: () => _showDialog(
  //               CupertinoPicker(
  //                 magnification: 1.22,
  //                 squeeze: 1.2,
  //                 useMagnifier: true,
  //                 itemExtent: _kItemExtent,
  //                 // This is called when selected item is changed.
  //                 onSelectedItemChanged: (int selectedItem) {
  //                   onInfractionChanged(Infraction.values[selectedItem]);
  //                 },
  //                 children: List<Widget>.generate(Infraction.values.length,
  //                     (int index) {
  //                   return Center(
  //                     child: Text(
  //                       _translateInfraction(Infraction.values[index]),
  //                     ),
  //                   );
  //                 }),
  //               ),
  //               context),
  //           // This displays the selected fruit name.
  //           child: Text(
  //             _translateInfraction(
  //                     Infraction.values[Infraction.values.indexOf(infraction)])
  //                 .toString(),
  //             style: const TextStyle(
  //               fontSize: 22.0,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  // void _showDialog(Widget child, BuildContext context) {
  //   showCupertinoModalPopup<void>(
  //       context: context,
  //       builder: (BuildContext context) => Container(
  //             height: 216,
  //             padding: const EdgeInsets.only(top: 6.0),
  //             // The Bottom margin is provided to align the popup above the system navigation bar.
  //             margin: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom,
  //             ),
  //             // Provide a background color for the popup.
  //             color: CupertinoColors.systemBackground.resolveFrom(context),
  //             // Use a SafeArea widget to avoid system overlaps.
  //             child: SafeArea(
  //               top: false,
  //               child: child,
  //             ),
  //           ));
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoSlidingSegmentedControl<Infraction>(
  //     children: Infraction.values.asMap().map(
  //         (e, infraction) => MapEntry(infraction, Text(infraction.toString()))),
  //     onValueChanged: (Infraction? infraction) {
  //       if (infraction != null) {
  //         onInfractionChanged(infraction);
  //       }
  //     },
  //     groupValue: infraction,
  //   );
  // }
// }
