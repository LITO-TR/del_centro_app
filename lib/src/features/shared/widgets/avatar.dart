import 'package:flutter/material.dart';
class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(),
          Text('Diana Torres',style: TextStyle(
            color: Colors.orangeAccent
          ),)
        ],
      ),
    );
  }
}
