import 'package:flutter/material.dart';
class ButtonWithIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final VoidCallback onPressed;
  final String label;

  const ButtonWithIcon({Key? key, required this.color, required this.iconData, required this.onPressed, required this.label }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(iconData),
      label: Text(label),
      style: ElevatedButton.styleFrom(backgroundColor: color, padding:  const EdgeInsets.symmetric(horizontal: 24, vertical: 16), )
    );
  }
}
