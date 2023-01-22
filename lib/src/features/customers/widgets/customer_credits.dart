import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:flutter/material.dart';

class CustomerCredits extends StatefulWidget {
  const CustomerCredits({Key? key,required this.credits}) : super(key: key);
  final List<Credit> credits;
  @override
  State<CustomerCredits> createState() => _CustomerCreditsState();

}



class _CustomerCreditsState extends State<CustomerCredits> {
@override
  void dispose() {
  // TODO: implement dispose
    super.dispose();
    // widget.credits.clear();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.credits.toString()),
        centerTitle: true,
      ),
      body: Row(
        children: [
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          // Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
          Text('customer detail')
        ],
      ),
    );
  }
}
