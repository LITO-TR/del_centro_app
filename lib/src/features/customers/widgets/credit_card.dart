import 'package:del_centro_app/src/core/services/credit_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';
class CreditCard extends StatefulWidget {
  const CreditCard({Key? key, required this.credit,required this.color}) : super(key: key);
  final Credit credit;
  final Color color;

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {

  late List<Credit> creditData;
  final creditService =CreditService();

  showDialogExtension(Credit credit) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
                child: Text(
                  "Pago",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                )),
            content: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellowAccent),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('Monto de credito: '),
                                Text('Deuda: '),
                                Text('Cuotas Pagadas: '),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ' ${credit.creditAmount}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${credit.debtAmount}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                FutureBuilder(
                                  future: creditService.getPaymentsByCredit(widget.credit.id.toString()),
                                  builder: (context, snapshot){
                                    if(snapshot.hasData){
                                        List<Payment> payments = snapshot.data!;
                                        Iterable<Payment> paid = payments.where((payment) => payment.status == 'PAGADO');
                                      return Text(
                                        '${paid.length}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      );
                                    }

                                    return const CircularProgressIndicator();
                                  },
                                ),
                              ],
                            )
                          ],
                        )
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ]
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: ()  {

                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          );
        });
    //return paymentService.setPayment(payment.id.toString(), dropDownValue,
    //  double.parse(txtCustomerPayment.text));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Styles.white,
      shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Colors.transparent),
          borderRadius: BorderRadius.circular(20)),
      child:    Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Text(widget.credit.creditAmount.toString(),style: const TextStyle(fontSize: 25),),
                Text('Monto de credito', style: TextStyle(color: Styles.backgroundOrange),)
              ],
            ),
          ),
          Text('${widget.credit.firstPayDate.toString()} -  ${widget.credit.expirationDate.toString()}'),
          OutlinedButton(
            onPressed: (){
            showDialogExtension(widget.credit);
          }, child:const Text('AMPLIACION'),),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))
            ),
            child: Center(child: Text(widget.credit.creditStatus.toString())),
          )
        ],
      ),
    );
  }
}
