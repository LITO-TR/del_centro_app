import 'package:flutter/material.dart';

class TitlesCredits extends StatelessWidget {
  const TitlesCredits({Key? key, required this.icon, required this.title, required this.fontSize}) : super(key: key);
  final IconData icon;
  final String title;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Icon(
          icon,
          color: Colors.green,
        ),
        Text(
          title,
          style:
          TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
