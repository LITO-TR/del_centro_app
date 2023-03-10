
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';

class InputCredit extends StatefulWidget {
  final String name;
  final TextEditingController controller;
  final String suffix;
  final String prefix;
  final double width;
  final TextInputType type;
  const InputCredit({Key? key, required this.name, required this.controller, required this.suffix, required this.prefix, required this.width, required this.type }) : super(key: key);

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
          Text(widget.name,style: const TextStyle(
            fontWeight: FontWeight.bold
          ),),
          const SizedBox(
            width: 10,
          ),
          Container(
              decoration: BoxDecoration(
               color: Styles.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(40),
              ),
              height: 45,
              width: widget.width,
              child: TextFormField(
                keyboardType: widget.type,
                autofocus: false,
                controller: widget.controller,
                decoration: InputDecoration(

                  suffixText: widget.suffix,
                  prefixText: widget.prefix,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,

                  ),

                ),
              )
          )
        ],
      ),
    );
  }
}
