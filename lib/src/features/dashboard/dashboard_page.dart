import 'package:del_centro_app/src/core/api/credit_service.dart';
import 'package:del_centro_app/src/core/api/payment_service.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  late Future<List<Payment>> _payments;
  late Future<Customer> _customer;

  final paymentService = PaymentService();
  final creditService = CreditService();
  @override
  void initState() {
    // TODO: implement initState
    final date = DateTime.now();
    _payments = paymentService.getPaymentsByDate(
        date.day.toString(), date.month.toString(), date.year.toString());

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
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Styles.blueDark,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '123',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.white),
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
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Styles.blueDark,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '123',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.white),
                            ),
                            Text(
                              'Monto a cobrar',
                              style: TextStyle(
                                  color: Styles.backgroundOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Styles.blueDark,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '123',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.white),
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
                  Text(
                    'CUOTAS DE HOY -> ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
              ),
              child: FutureBuilder<List<Payment>>(
                future: _payments,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Payment> listPayment = snapshot.data!;

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
                          if(listPayment[index].status == "PENDIENTE"){
                            colorStatus = Colors.red;
                            labelStatus = 'D';
                          }
                          else if(listPayment[index].status == "PAGADO"){
                            colorStatus = Colors.green;
                            labelStatus = 'P';
                          }
                          return SizedBox(
                            height: 70,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 4,
                              child: FutureBuilder<Customer>(
                                  future: _customer,
                                  builder: (context, snap) {
                                    if (snapshot.hasData) {
                                      if (snap.data == null) {
                                        return const Center(child: LinearProgressIndicator());
                                      }
                                      Customer customer = snap.data!;
                                      print(snapshot.error);
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
                                                    color: Styles
                                                        .backgroundOrange),
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
                                                    color: Colors.green,
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
                                              Text('Pago:'),
                                              Text(listPayment[index].payment.toString())
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [Text('Estado'),
                                              Container(
                                                height: 25,
                                              width:20,
                                              decoration: BoxDecoration(
                                                        color: colorStatus
                                                        ),
                                                  child:
                                              Center(
                                                child: Text(labelStatus,style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23
                                                ),),
                                              )
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Acciones'),
                                              ElevatedButton(
                                                  onPressed: () async{
                                                    listPayment[index] = await  paymentService.setPayment(listPayment[index].id.toString());
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                      Icons.monetization_on))
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                    else if (snapshot.hasError) {
                                      print(snapshot.error);
                                      return Text('${snapshot.error}');
                                    }
                                    return  Center(
                                        child:  CircularProgressIndicator());
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
          Column(
            children: [
              Row(children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                Text(
                  ' :PAGADO',
                  style: TextStyle(
                      color: Styles.blueDark, fontWeight: FontWeight.bold),
                )
              ]),
              Row(children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.orange,
                ),
                Text(
                  ' :PENDIENTE',
                  style: TextStyle(
                      color: Styles.blueDark, fontWeight: FontWeight.bold),
                )
              ])
            ],
          ),
        ],
      ),
    );
  }
}
