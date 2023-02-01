import 'package:del_centro_app/src/core/api/credit_service.dart';
import 'package:del_centro_app/src/core/api/payment_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/features/credit/widgets/input_credit.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomerCreditDetail extends StatefulWidget {
  const CustomerCreditDetail({Key? key, required this.credit, required this.customer})
      : super(key: key);
  final Credit credit;
  final Customer customer;
  @override
  State<CustomerCreditDetail> createState() => _CustomerCreditDetailState();
}

class _CustomerCreditDetailState extends State<CustomerCreditDetail> {
  final paymentService = PaymentService();
  final creditService = CreditService();
  late Credit creditData;
  late List<Payment> paymentsData;

  late Future<List<Payment>> _payments;
  TextEditingController txtCustomerPayment = TextEditingController();
  TextEditingController txtPaymentMethod = TextEditingController();
  static const List<String> list = <String>['EFECTIVO', 'DEPOSITO'];
  String dropDownValue = list.first;

  TextStyle style = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState
    creditData = widget.credit;
    _payments = creditService.getPaymentsByCredit(widget.credit.id.toString());
    super.initState();
  }

  /*Future<Payment>*/ showDialogPayment(int index) {
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
                              Text('Nro de Cuota: '),
                              Text('Fecha: '),
                              Text('Monto de cuota: '),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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
                      name: 'Pago',
                      controller: txtCustomerPayment,
                      suffix: '',
                      prefix: '',
                      width: 150,
                      type: TextInputType.number),
                  Text(
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
                  paymentsData[index] = await  paymentService.setPayment(paymentsData[index].id.toString(),dropDownValue, double.parse(txtCustomerPayment.text));
                  creditData = await creditService.getCreditbyId(paymentsData[index].creditId.toString());
                  setState(() {});
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
    //return paymentService.setPayment(payment.id.toString(), dropDownValue,
      //  double.parse(txtCustomerPayment.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.name.toString()),
        centerTitle: true,
        backgroundColor: Styles.blueDark,
      ),
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Styles.backgroundOrange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'PRODUCTO:  ',
                            style: style,
                          ),
                          Text('MONTO DEL PRESTAMOS:  ', style: style),
                          Text('INTERES (%):  ', style: style),
                          Text('MONTO INTERES (S/):  ', style: style),
                          Text('DEVOLUCION TOTAL:  ', style: style),
                          Text('CUOTA:  ', style: style),
                          Text('PERIODICIDAD DE PAGO:  ', style: style),
                          Text('MORA DIARIA:  ', style: style),
                          Text('PRIMER DIA DE PAGO:  ', style: style),
                          Text('FECHA DE VENCIMIENTO:  ', style: style),
                          Text('MONTO DESEMBOLSADO:  ', style: style),
                          Text('DUEDA:  ', style: style),
                          Text('ESTADO:  ', style: style)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(creditData.creditType.toString()),
                          Text(creditData.creditAmount.toString()),
                          Text((creditData.decimalInterest! * 100).toString()),
                          Text(creditData.interestAmount.toString()),
                          Text(creditData.totalAmount.toString()),
                          Text(creditData.paymentsAmount.toString()),
                          Text(creditData.paymentMethod.toString()),
                          Text(creditData.mora.toString()),
                          Text(creditData.firstPayDate.toString()),
                          Text(creditData.expirationDate.toString()),
                          Text(creditData.disbursedAmount.toString()),
                          Text(creditData.debtAmount.toString()),
                          Text(creditData.creditStatus.toString()),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FutureBuilder<List<Payment>>(
                      future: _payments,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Payment> listPayments = snapshot.data!;
                          paymentsData =snapshot.data!;
                          return Card(
                            elevation: 5,
                            borderOnForeground: true,
                            child: SingleChildScrollView(
                              child: DataTable(
                                  headingTextStyle: TextStyle(
                                      color: Styles.backgroundOrange,
                                      fontWeight: FontWeight.bold),
                                  headingRowColor: MaterialStateColor.resolveWith(
                                      (states) => Styles.blueDark),
                                  border: TableBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  columns: const [
                                    DataColumn(label: Center(child: Text('Nro'))),
                                    DataColumn(
                                        label: Center(
                                            child: Text('Fecha de Vencimiento'))),
                                    DataColumn(
                                        label: Center(child: Text('Cuota (S/)'))),
                                    DataColumn(
                                        label: Center(child: Text('Estado'))),
                                    DataColumn(
                                        label: Center(child: Text('Dia de Pago'))),
                                    DataColumn(
                                        label: Center(child: Text('Dias Mora'))),
                                    DataColumn(
                                        label:
                                            Center(child: Text('Metodo de Pago'))),
                                    DataColumn(
                                        label:
                                            Center(child: Text('Monto de Pago'))),
                                    DataColumn(
                                        label: Center(child: Text('Acciones'))),
                                  ],
                                  rows: List<DataRow>.generate(listPayments.length,
                                      (index) {
                                       // paymentData = listPayments[index];

                                    Color colorChip = Colors.grey;
                                    if (paymentsData[index].status == "PENDIENTE") {
                                      colorChip = Colors.red;
                                    } else if (paymentsData[index].status ==
                                        "PAGADO") {
                                      colorChip = Colors.green;
                                    }
                                    return DataRow(
                                        // color: MaterialStateColor.resolveWith((states) => Styles.backgroundOrange),
                                        cells: [
                                          DataCell(Center(
                                            child: Text(paymentsData[index]
                                                .paymentOrder
                                                .toString()),
                                          )),
                                          DataCell(Center(
                                            child: Text(paymentsData[index]
                                                .date
                                                .toString()),
                                          )),
                                          DataCell(Center(
                                            child: Text(paymentsData[index]
                                                .payment
                                                .toString()),
                                          )),
                                          DataCell(
                                            Chip(
                                                backgroundColor: colorChip,
                                                label: Text(
                                                  paymentsData[index]
                                                      .status
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                          DataCell(Center(
                                            child: Text(paymentsData[index]
                                                .paymentDate
                                                .toString()),
                                          )),
                                          DataCell(Center(
                                            child: Text(paymentsData[index]
                                                .moraDays
                                                .toString()),
                                          )),
                                          DataCell(Center(
                                            child: Text(paymentsData[index]
                                                .paymentMethod
                                                .toString()),
                                          )),
                                          DataCell(Center(
                                            child: Text(paymentsData[index]
                                                .customerPayment
                                                .toString()),
                                          )),
                                          DataCell(Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: ()  {
                                                      showDialogPayment(index);
                                                  },
                                                  child: const Icon(
                                                      Icons.monetization_on))
                                            ],
                                          ))
                                        ]);
                                  })),
                            ),
                          );
                          // ),
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text('${snapshot.error}');
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
