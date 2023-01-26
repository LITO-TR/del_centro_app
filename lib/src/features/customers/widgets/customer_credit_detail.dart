import 'package:del_centro_app/src/core/api/credit_service.dart';
import 'package:del_centro_app/src/core/api/payment_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomerCreditDetail extends StatefulWidget {
  const CustomerCreditDetail({Key? key, required this.credit}) : super(key: key);
  final Credit credit;
  @override
  State<CustomerCreditDetail> createState() => _CustomerCreditDetailState();
}

class _CustomerCreditDetailState extends State<CustomerCreditDetail> {

  final paymentService = PaymentService();
  final creditService = CreditService();

  late Future<List<Payment>> _payments;

  TextStyle style = TextStyle(color: Colors.white,fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState
    _payments = creditService.getPaymentsByCredit(widget.credit.id.toString());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hola'),
        centerTitle: true,
        backgroundColor: Styles.blueDark,

      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.35,
              width: MediaQuery.of(context).size.width*0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Styles.backgroundOrange
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:  [
                      Text('PRODUCTO:  ',style: style,),
                      Text('MONTO DEL PRESTAMOS:  ',style: style),
                      Text('INTERES (%):  ',style: style),
                      Text('MONTO INTERES (S/):  ',style: style),
                      Text('DEVOLUCION TOTAL:  ',style: style),
                      Text('CUOTA:  ',style: style),
                      Text('PERIODICIDAD DE PAGO:  ',style: style),
                      Text('MORA DIARIA:  ',style: style),
                      Text('PRIMER DIA DE PAGO:  ',style: style),
                      Text('FECHA DE VENCIMIENTO:  ',style: style),
                      Text('MONTO DESEMBOLSADO:  ',style: style)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(widget.credit.creditType.toString()),
                      Text(widget.credit.creditAmount.toString()),
                      Text((widget.credit.decimalInterest!*100).toString()),
                      Text(widget.credit.interestAmount.toString()),
                      Text(widget.credit.totalAmount.toString()),
                      Text(widget.credit.paymentsAmount.toString()),
                      Text(widget.credit.paymentMethod.toString()),
                      Text(widget.credit.mora.toString()),
                      Text(widget.credit.firstPayDate.toString()),
                      Text(widget.credit.expirationDate.toString()),
                      Text(widget.credit.disbursedAmount.toString()),

                    ],
                  )
                ],
              ),

            ),
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              width: MediaQuery.of(context).size.width*0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: FutureBuilder<List<Payment>>(
                future: _payments,
                builder: (context, snapshot){
                    if(snapshot.hasData){
                      List<Payment> listPayments = snapshot.data!;
                      return Card(
                        elevation: 5,
                        borderOnForeground: true,
                        child: SingleChildScrollView(
                          child: DataTable(
                              headingTextStyle: TextStyle(color: Styles.backgroundOrange,fontWeight: FontWeight.bold),
                              headingRowColor: MaterialStateColor.resolveWith((states) => Styles.blueDark),
                              border: TableBorder(borderRadius: BorderRadius.circular(20)),

                              columns: const [
                                DataColumn(label: Center(child: Text('Nro'))),
                                DataColumn(label: Center(child: Text('Fecha de Vencimiento'))),
                                DataColumn(label: Center(child: Text('Monto de Pago (S/)'))),
                                DataColumn(label: Center(child: Text('Estado'))),
                                DataColumn(label: Center(child: Text('Dias de Mora'))),
                                DataColumn(label: Center(child: Text('Dia de Pago'))),
                                DataColumn(label: Center(child: Text('Acciones'))),

                              ],
                              rows: List<DataRow>.generate(
                                  listPayments.length,
                                      (index) {

                                    Color colorChip = Colors.grey;
                                    if(listPayments[index].status == "PENDIENTE"){
                                      colorChip = Colors.red;
                                    }
                                    else if(listPayments[index].status == "PAGADO"){
                                      colorChip = Colors.green;
                                    }
                                    return DataRow(
                                      // color: MaterialStateColor.resolveWith((states) => Styles.backgroundOrange),
                                        cells: [
                                          DataCell(Center(
                                            child: Text(
                                                listPayments[index].paymentOrder
                                                    .toString()),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                                listPayments[index].date
                                                    .toString()),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                                listPayments[index].payment
                                                    .toString()),
                                          )),
                                          DataCell(
                                                Chip(
                                                    backgroundColor: colorChip,
                                                    label: Text(
                                                      listPayments[index].status.toString(),
                                                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                                    )
                                                ),
                                          ),
                                          DataCell(Center(
                                            child: Text(
                                                listPayments[index].moraDays
                                                    .toString()),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                                listPayments[index].paymentDate
                                                    .toString()),
                                          )),
                                          DataCell(Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () async{
                                                    listPayments[index] = await  paymentService.setPayment(listPayments[index].id.toString());
                                                    setState(() {});
                                                    },
                                                  child: const Icon(
                                                      Icons.monetization_on)
                                              )
                                            ],
                                          ))

                                        ]);
                                  }
                              )
                          ),
                        ),
                      );
                      // ),
                  }
                  else if (snapshot.hasError) {
                      print(snapshot.error);
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                      child: CircularProgressIndicator()
                  );
                }

              ),
            )
          ],
        ),
      ),
    );
  }
}
