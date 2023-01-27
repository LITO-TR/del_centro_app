
import 'package:del_centro_app/src/core/api/credit_service.dart';
import 'package:del_centro_app/src/core/api/payment_service.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

double sumOfPayments = 0.0;
double sumOfPaymentsPaid = 0.0;

class _DashboardPage extends State<DashboardPage> {
  late Future<List<Payment>> _payments;
  late Future<Customer> _customer;

  final paymentService = PaymentService();
  final creditService = CreditService();
  final date = DateTime.now();
    TextEditingController txtDay = TextEditingController();
  TextEditingController txtMonth = TextEditingController();
  TextEditingController txtYear = TextEditingController();

  //TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _payments = paymentService.getPaymentsByDate(
        date.day.toString(), date.month.toString(), date.year.toString());
    txtDay.text = 'd';
    txtMonth.text = 'mm';
    txtYear.text = 'yyyy';
    //sumOfPayments =0.0;
    //sumOfPaymentsPaid=0.0;
   // dateController.text = "";

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('entreeeee');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sumOfPayments.toStringAsFixed(2),
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    Text(
                      'Monto por cobrar',
                      style: TextStyle(
                          color: Styles.blueDark, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                    color: Styles.blueDark,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sumOfPaymentsPaid.toStringAsFixed(2),
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    Text(
                      'Monto cobrado',
                      style: TextStyle(
                          color: Styles.backgroundOrange,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                    color: Styles.blueDark,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '123',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    Text(
                      'Monto desembolsado',
                      style: TextStyle(
                          color: Styles.backgroundOrange,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 300,
          height: 100,
          child: CupertinoDatePicker(
            mode:  CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            maximumDate:  DateTime(2030),
            minimumDate: DateTime(2022),
            onDateTimeChanged: (date){
              txtDay.text = date.day.toString();
              txtMonth.text = date.month.toString();
              txtYear.text = date.year.toString();
              setState(() {
              });
            },

          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${txtYear.text}/${txtMonth.text}/${txtDay.text}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold, ),),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(onPressed: ()  async{

                  String day = txtDay.text;
                  String month = txtMonth.text;
                  String year = txtYear.text ;

                  _payments =  paymentService.getPaymentsByDate(day, month, year/*txtDay.text, txtMonth.text, txtYear.text*/);
                 /* var list = await paymentService.getPaymentsByDate(txtDay.text, txtMonth.text, txtYear.text);
                  var amountReceivable;
                  var amountCollected;

                    for (int i = 0; i < list.length; i++) {
                      amountReceivable += list[i].payment!;
                      sumOfPayments = amountReceivable;
                      if (list[i].status == "PAGADO") {
                        amountCollected += 0;
                        sumOfPaymentsPaid = amountCollected;
                      }
                    }*/

                  setState(() { });
                }, child: Text('Buscar'))
              ],
            ),
        ),

        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
            ),
            child: FutureBuilder<List<Payment>>(
              future: _payments,
              builder: (context, snapshot) {
                double amountCollected = 0.0;
                double amountReceivable = 0.0;
                if (snapshot.hasData) {
                  List<Payment> listPayment = snapshot.data!;

                  for (int i = 0; i < listPayment.length; i++) {
                    amountReceivable += listPayment[i].payment!;
                    sumOfPayments = amountReceivable;
                    if (listPayment[i].status == "PAGADO") {
                      amountCollected += listPayment[i].payment!;
                      sumOfPaymentsPaid = amountCollected;
                    }
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay cobranzas hoy',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: listPayment.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, int index) {
                      _customer = creditService.getCustomerByCreditId(
                          listPayment[index].creditId.toString());
                      Color colorStatus = Colors.grey;
                      String labelStatus = 'E';
                      if (listPayment[index].status == "PENDIENTE") {
                        colorStatus = Colors.red;
                        labelStatus = 'D';
                      } else if (listPayment[index].status == "PAGADO") {
                        colorStatus = Colors.green;
                        labelStatus = 'P';
                      }
                      return SizedBox(
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 4,
                          child: FutureBuilder<Customer>(
                              future: _customer,
                              builder: (context, snap) {
                                if (snapshot.hasData) {
                                  if (snap.data == null) {
                                    return const Center(
                                        child: LinearProgressIndicator());
                                  }
                                  Customer customer = snap.data!;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nro',
                                            style: TextStyle(
                                                color: Styles.backgroundOrange),
                                          ),
                                          Text((index + 1).toString()),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_month),
                                              Text(
                                                'Fecha',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          Text(listPayment[index]
                                              .date.toString()),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: Colors.yellow,
                                              ),
                                              Text(
                                                'Cliente',
                                                style: TextStyle(
                                                    color: Styles.blueDark,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(customer.name),
                                          Text(customer.lastName)
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.home,
                                                color: Colors.brown,
                                              ),
                                              Text(
                                                'Direccion',
                                                style: TextStyle(
                                                    color: Styles.blueDark,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(customer.address)
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: Colors.blue,
                                              ),
                                              Text(
                                                'Cell',
                                                style: TextStyle(
                                                    color: Styles.blueDark,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(customer.phoneNumber)
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.attach_money,
                                                color: Colors.green,
                                              ),
                                              Text('Pago',
                                                  style: TextStyle(
                                                      color: Styles.blueDark,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          Text(listPayment[index]
                                              .payment
                                              .toString())
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Estado',
                                            style: TextStyle(
                                                color: Styles.blueDark,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                              height: 25,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: colorStatus),
                                              child: Center(
                                                child: Text(
                                                  labelStatus,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 23),
                                                ),
                                              ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Acciones',
                                            style: TextStyle(
                                                color: Styles.blueDark,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          ElevatedButton(
                                              onPressed: () async {
                                                listPayment[index] =
                                                    await paymentService
                                                        .setPayment(
                                                            listPayment[index]
                                                                .id
                                                                .toString());
                                                setState(() {});
                                                if (sumOfPaymentsPaid <=
                                                    sumOfPayments) {
                                                  setState(() {
                                                    sumOfPaymentsPaid +=
                                                        listPayment[index]
                                                            .payment!;
                                                  });
                                                } else {
                                                  sumOfPaymentsPaid += 0;
                                                }
                                              },
                                              child:
                                                  Icon(Icons.monetization_on))
                                        ],
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return Text('${snapshot.error}');
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  print('${snapshot.error}');
                  return Text('error: ${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            )),
          ]
        ),
    );
  }
}
