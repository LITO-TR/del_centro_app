import 'package:del_centro_app/src/core/services/credit_service.dart';
import 'package:del_centro_app/src/core/services/payment_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/features/credits/widgets/input_credit.dart';
import 'package:del_centro_app/src/features/customers/screen/customer_credit_detail.dart';
import 'package:del_centro_app/src/features/payments/widgets/payments_content.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/payment_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

double sumOfPayments = 0.0;
double sumOfPaymentsPaid = 0.0;

class _DashboardPage extends State<DashboardPage> {
  late Future<Customer> _customer;

  late List<Payment> paymentsData;
  TextEditingController txtCustomerPayment = TextEditingController();
  TextEditingController txtPaymentMethod = TextEditingController();

  static const List<String> list = <String>['EFECTIVO', 'DEPOSITO'];
  String dropDownValue = list.first;
  late DateTime? current;
  final paymentService = PaymentService();
  final creditService = CreditService();
  final date = DateTime.now();
  TextEditingController txtDay = TextEditingController();
  TextEditingController txtMonth = TextEditingController();
  TextEditingController txtYear = TextEditingController();
  @override
  void initState() {
    current = DateTime.now();
    Provider.of<PaymentProvider>(context,listen:  false).getPaymentsByDate(current!.day.toString(), current!.month.toString(), current!.year.toString());

    super.initState();
  }
  showDialogPayment(int index, Payment payment) {
    showDialog(
        context: context,
        builder: (context) {
          final paymentProvider = context.watch<PaymentProvider>();
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
                              Text('Nro de Cuota: '),
                              Text('Fecha: '),
                              Text('Monto de cuota: '),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                ' ${payment.paymentOrder}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${payment.date}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${payment.payment}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(
                      name: 'Pago',
                      controller: txtCustomerPayment,
                      suffix: '',
                      prefix: '',
                      width: 150,
                      type: TextInputType.number),
                  const Text(
                    'METODO DE PAGO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Styles.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: 150,
                    child: DropdownButtonFormField(
                        value: dropDownValue,
                        dropdownColor: Styles.backgroundOrange,
                        iconEnabledColor: Styles.blueDark,
                        decoration: const InputDecoration(
                          border:
                          OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        items:
                        list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropDownValue = value!;
                          });
                        }),
                  ),
                ],
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
                onPressed: () async {
                  paymentProvider.makePaymentDaily(
                      index,
                      payment.id.toString(),
                      dropDownValue,
                      double.parse(txtCustomerPayment.text));
                  txtCustomerPayment.clear();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Guardar",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.watch<PaymentProvider>();

    return ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.95,
            child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: ()async{
                      current = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2024),
                      );
                      setState(() {});
                      if(current == null){
                        current = DateTime.now();
                        paymentProvider.getPaymentsByDate(current!.day.toString(), current!.month.toString(), current!.year.toString());
                      }
                      paymentProvider.getPaymentsByDate(current!.day.toString(), current!.month.toString(), current!.year.toString());

                    },
                    child:
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                            'Fecha:${current!.year.toString()}/${current!.month.toString()}/${current!.day.toString()}',style: const TextStyle(fontSize: 28), ),
                    ),
                    ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                ),
                // paymentProvider.listPaymentsByDate.isEmpty?
                child: paymentProvider.listPaymentsByDate.isEmpty?const Center(child: Text('No hay cobranzas por realizar',style: TextStyle(color: Colors.red,fontSize: 30),)):ListView.builder(
                  itemCount: paymentProvider.listPaymentsByDate.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, int index) {
                    _customer = creditService.getCustomerByCreditId(
                        paymentProvider.listPaymentsByDate[index].creditId.toString());
                    Color colorStatus = Colors.grey;
                    String labelStatus = 'E';
                    if (paymentProvider.listPaymentsByDate[index].status == "PENDIENTE") {
                      colorStatus = Colors.red;
                      labelStatus = 'D';
                    } else if (paymentProvider.listPaymentsByDate[index].status == "PAGADO") {
                      colorStatus = Colors.green;
                      labelStatus = 'P';
                    }
                    return SizedBox(
                      height: 80,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20)),
                        child: FutureBuilder<Customer>(
                            future: _customer,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data == null) {
                                  return const Center(
                                      child: LinearProgressIndicator());
                                }
                                Customer customer = snapshot.data!;
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Nro',
                                          style: TextStyle(
                                              color: Styles.backgroundOrange),
                                        ),
                                        Text((index + 1).toString()),
                                      ],
                                    ),
                                    PaymentsContent(title: 'Fecha', icon: Icons.calendar_month, value: paymentProvider.listPaymentsByDate[index]
                                        .date.toString(),color: Colors.red,),// red
                                    PaymentsContent(title: 'Cliente', icon: Icons.person, value: '${customer.name.toString()}\n${customer.lastName.toString()}',color: Colors.yellow,),//blue
                                    PaymentsContent(title: 'Cell', icon: Icons.phone, value: customer.phoneNumber.toString(),color: Colors.blue,),//blue
                                    PaymentsContent(title: 'Cuota:(S/)', icon: Icons.attach_money, value: paymentProvider.listPaymentsByDate[index]
                                        .payment
                                        .toString(),color: Colors.green),//green
                                    PaymentsContent(title: 'Metodo Pago', icon: Icons.handshake_sharp, value: paymentProvider.listPaymentsByDate[index]
                                        .paymentMethod
                                        .toString(),color: Colors.red,),//red
                                    PaymentsContent(title: 'Monto pago', icon: Icons.money, value: paymentProvider.listPaymentsByDate[index]
                                        .customerPayment
                                        .toString(),color: Colors.red,),//red
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
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
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 23),
                                              ),
                                            ))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Acciones',
                                          style: TextStyle(
                                              color: Styles.blueDark,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  showDialogPayment(
                                                      index, paymentProvider.listPaymentsByDate[index]);
                                                  setState((){});
                                                },
                                                child: const Icon(Icons.paid)),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            ElevatedButton(
                                                onPressed: () async{
                                                  Credit credit = await creditService.getCreditbyId(paymentProvider.listPaymentsByDate[index].creditId.toString());
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => CustomerCreditDetail(credit: credit, customer: customer),
                                                  ));
                                                },
                                                child: const Icon(Icons.remove_red_eye_outlined)),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ],
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator(
                                  )
                              );
                            }),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ]
    );
  }
}
