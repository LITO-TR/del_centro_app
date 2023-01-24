import 'package:del_centro_app/src/core/api/credit_service.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:flutter/material.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {

  late Future<List<Payment>> payments;
  final creditService = CreditService();
  @override
  void initState() {
    // TODO: implement initState
    //payments = creditService
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red
            ),
            child: FutureBuilder<List<Payment>>(
              future: payments,
              builder: (context, snapshot){
                return const CircularProgressIndicator();
              },
            )
          )
        ],
      ),
    );

  }
}
