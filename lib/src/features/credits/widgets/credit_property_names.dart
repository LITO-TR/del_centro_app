import 'package:flutter/material.dart';

import '../../../styles/styles.dart';
class CreditPropertiesNames extends StatelessWidget {
  const CreditPropertiesNames({Key? key, required this.title, required this.value}) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 25,
              color: Colors.white),
        ),
        Text(
          title,
          style: TextStyle(
              color: Styles.backgroundOrange),
        )
      ],
    );
  }
}
