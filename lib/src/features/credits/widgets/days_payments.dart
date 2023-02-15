import 'package:flutter/material.dart';

import '../../../styles/styles.dart';

class DaysPayments extends StatelessWidget {
  const DaysPayments({Key? key, required this.title, required this.value}) : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Styles.blueDark,
          ),
        ),
        Text(
          value,
          style: TextStyle(
              color: Styles.blueDark,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
