import 'package:del_centro_app/src/core/services/customer_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';


class CustomerCard extends StatelessWidget {
  const CustomerCard({Key? key, required this.customer,}) : super(key: key);
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Styles.white,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${customer.name} ',
                  style: TextStyle(
                      color: Styles.blueDark, fontWeight: FontWeight.bold),
                ),
                Text(
                  customer.lastName.toString(),
                  style: TextStyle(
                      color: Styles.backgroundOrange,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.credit_card_outlined,
                        color: Colors.blue,
                      ),
                      Text(
                        customer.dni.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                      Text(
                        customer.phoneNumber.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ]),
                SizedBox(
                  child: FutureBuilder<List<Credit>>(
                    future: CustomerService().getCreditsByCustomerId(
                        customer.id.toString()),
                    builder: (context, snapshot) {
                        if(snapshot.hasData){
                          List<Credit> credits =
                              snapshot.data ?? [];
                          IconData icon =
                              Icons.check_circle;
                          Color color = Colors.black;
                          if (credits.length >= 8) {
                            icon = Icons.emoji_events;
                            color = Colors.amberAccent;
                          } else if (credits.length < 8 && credits.isNotEmpty) {
                            icon = Icons
                                .emoji_emotions_outlined;
                            color = Colors.deepPurple;
                          }
                          else if(credits.isEmpty){
                            credits.length = 0;
                            icon = Icons.child_care;
                            color = Colors.teal;
                          }

                          return Column(
                            children: [
                              Text(
                                '${credits.length} Creditos',
                                style: const TextStyle(
                                    color: Colors.grey),
                              ),
                              Icon(icon, color: color,size: 30,)
                            ],
                          );
                        }

                        return const Center(child: Text('waiting credits...'),);
                    },
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
