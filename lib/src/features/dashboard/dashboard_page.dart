import 'package:del_centro_app/src/core/api/credit_service.dart';
import 'package:del_centro_app/src/core/api/payment_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/features/credit/widgets/input_credit.dart';
import 'package:del_centro_app/src/features/customers/screen/customer_credit_detail.dart';
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

  late List<Payment> paymentsData;
  TextEditingController txtCustomerPayment = TextEditingController();
  TextEditingController txtPaymentMethod = TextEditingController();

  static const List<String> list = <String>['EFECTIVO', 'DEPOSITO'];
  String dropDownValue = list.first;

  final paymentService = PaymentService();
  final creditService = CreditService();
  final date = DateTime.now();
  TextEditingController txtDay = TextEditingController();
  TextEditingController txtMonth = TextEditingController();
  TextEditingController txtYear = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _payments = paymentService.getPaymentsByDate(
        date.day.toString(), date.month.toString(), date.year.toString());
    txtDay.text = 'd';
    txtMonth.text = 'mm';
    txtYear.text = 'yyyy';

    super.initState();
  }


  showDialogPayment(int index, Customer customer) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
                child: Text(
              "Confirmar Pago",
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
                              Text('Cliente: '),
                              Text('Nro de Cuota: '),
                              Text('Fecha de Vencimiento: '),
                              Text('Cuota: '),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                ' ${customer.name} ${customer.lastName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' ${paymentsData[index].paymentOrder}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${paymentsData[index].date}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${paymentsData[index].payment}',
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
                      name: 'MONTO PAGADO',
                      controller: txtCustomerPayment,
                      suffix: '',
                      prefix: '',
                      width: 150,
                    type: TextInputType.number,),
                  const Text(
                    'METODO PAGO',
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
                  paymentsData[index] = await paymentService.setPayment(
                      paymentsData[index].id.toString(),
                      dropDownValue,
                      double.parse(txtCustomerPayment.text));
                  setState(() {});
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

  showDataPicker(){

  }

  @override
  Widget build(BuildContext context) {
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
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  width: 300,
                  height: 100,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    maximumDate: DateTime(2030),
                    minimumDate: DateTime(2022),
                    onDateTimeChanged: (date) {
                      txtDay.text = date.day.toString();
                      txtMonth.text = date.month.toString();
                      txtYear.text = date.year.toString();
                      setState(() {});
                    },
                  ),
                ),
                MaterialButton(onPressed: ()async{

                  DateTime? current = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2024),
                  );
                  print(current);

                },
                child: const Text('date'),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)),
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                String day = txtDay.text;
                                String month = txtMonth.text;
                                String year = txtYear.text;

                                _payments = paymentService.getPaymentsByDate(
                                    day,
                                    month,
                                    year /*txtDay.text, txtMonth.text, txtYear.text*/);
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

                                setState(() {});
                              },
                              child: Text('Buscar')),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${txtYear.text}/${txtMonth.text}/${txtDay.text}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                child: FutureBuilder<List<Payment>>(
                  future: _payments,
                  builder: (context, snapshot) {
                    double amountCollected = 0.0;
                    double amountReceivable = 0.0;
                    if (snapshot.hasData) {
                      paymentsData = snapshot.data!;
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
                            'Hoy no hay cobranzas',
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
                            height: 80,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(20)),
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
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    'Fecha',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Text(listPayment[index]
                                                  .date
                                                  .toString()),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
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
                                              Text(customer.name.toString()),
                                              Text(customer.lastName.toString())
                                            ],
                                          ),
                                          /*Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
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
                                            Text(customer.address.toString())
                                          ],
                                        ),*/
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
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
                                              Text(customer.phoneNumber.toString())
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.attach_money,
                                                    color: Colors.green,
                                                  ),
                                                  Text('Cuota(S/)',
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
                                            CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.handshake_sharp,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    'Metodo Pago',
                                                    style: TextStyle(
                                                        color: Styles.blueDark,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Text(listPayment[index]
                                                  .paymentMethod
                                                  .toString())
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.money,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    'Monto Pago',
                                                    style: TextStyle(
                                                        color: Styles.blueDark,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Text(listPayment[index]
                                                  .customerPayment
                                                  .toString())
                                            ],
                                          ),
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
                                                            index, customer);
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
                                                      child: Icon(Icons.paid)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () async{
                                                        Credit credit = await creditService.getCreditbyId(listPayment[index].creditId.toString());
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
                                    } else if (snapshot.hasError) {
                                      print(snapshot.error);
                                      return Text('${snapshot.error}');
                                    }
                                    return const Center(
                                        child: CircularProgressIndicator(
                                        ));
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
          ]),
        ),
      ]
    );
  }
}
