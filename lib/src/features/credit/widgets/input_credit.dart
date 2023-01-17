import 'package:flutter/material.dart';

class InputCredit extends StatefulWidget {
  final String name;
  final TextEditingController controller;
  final String suffix;
  final String prefix;
  final double width;
  const InputCredit({Key? key, required this.name, required this.controller, required this.suffix, required this.prefix, required this.width }) : super(key: key);

  @override
  State<InputCredit> createState() => _InputCreditState();
}

class _InputCreditState extends State<InputCredit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name),
          SizedBox(
            width: 10,
          ),
          Container(
              width: widget.width,
              child: TextFormField(
                controller: widget.controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(

                  suffixText: widget.suffix,
                  prefixText: widget.prefix,
                  border: const OutlineInputBorder(),

                ),
              )
          )
        ],
      ),
    );
  }
}
