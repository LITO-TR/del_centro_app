import 'package:flutter/material.dart';
class PaymentsContent extends StatelessWidget {
  const PaymentsContent({Key? key, required this.title, required this.icon, required this.value,required this.color}) : super(key: key);
  final String title;
  final IconData icon;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontWeight:
                  FontWeight.bold),
            ),
          ],
        ),
        Text(value),
      ],
    );
  }
}
