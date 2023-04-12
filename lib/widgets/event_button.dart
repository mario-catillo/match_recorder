import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  final String name;
  final void Function() onPressed;
  final String? icon;
  final Color? buttoncolor;

  const EventButton(
      {Key? key,
      required this.name,
      required this.onPressed,
      this.icon,
      this.buttoncolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? curIcon = icon;
    Color color = buttoncolor ?? Colors.grey.shade200;
    return MaterialButton(
      onPressed: () => onPressed(),
      color: color,
      child: Column(
        children: [
          if (curIcon != null) Image.asset(curIcon, width: 50, height: 50),
          Text(name),
        ],
      ),
    );
  }
}
