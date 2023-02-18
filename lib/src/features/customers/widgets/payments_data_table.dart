import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/credit.dart';
import '../../../core/models/customer.dart';
import '../../../core/models/payment.dart';
import '../../../providers/customer_provider.dart';
import '../../../styles/styles.dart';
import '../../credits/widgets/input_credit.dart';

class PaymentsDataTable extends StatefulWidget {
  const PaymentsDataTable(
      {Key? key,
      required this.payments,
      required this.customer,
      required this.credit})
      : super(key: key);
  final List<Payment> payments;
  final Customer customer;
  final Credit credit;
  @override
  State<PaymentsDataTable> createState() => _PaymentsDataTableState();
}

class _PaymentsDataTableState extends State<PaymentsDataTable> {
  static const List<String> list = <String>['EFECTIVO', 'DEPOSITO'];
  String dropDownValue = list.first;
  TextEditingController txtCustomerPayment = TextEditingController();

  showDialogPayment(int index, Payment payment) {
    showDialog(
        context: context,
        builder: (context) {
          final customerProvider = context.watch<CustomerProvider>();
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
                  customerProvider.makePaymentCustomer(
                      widget.customer.id.toString(),
                      widget.credit.id.toString(),
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
    final customerProvider = context.watch<CustomerProvider>();
    return Card(
      elevation: 5,
      borderOnForeground: true,
      child: SingleChildScrollView(
        child: DataTable(
            headingTextStyle: TextStyle(
                color: Styles.backgroundOrange, fontWeight: FontWeight.bold),
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Styles.blueDark),
            columns: const [
              DataColumn(label: Center(child: Text('Nro'))),
              DataColumn(label: Center(child: Text('Fecha de Vencimiento'))),
              DataColumn(label: Center(child: Text('Cuota (S/)'))),
              DataColumn(label: Center(child: Text('Estado'))),
              DataColumn(label: Center(child: Text('Dia de Pago'))),
              DataColumn(label: Center(child: Text('Dias Mora'))),
              DataColumn(label: Center(child: Text('Metodo de Pago'))),
              DataColumn(label: Center(child: Text('Monto de Pago'))),
              DataColumn(label: Center(child: Text('Acciones'))),
            ],
            rows: List<DataRow>.generate(widget.payments.length, (index) {
              Color colorChip = Colors.grey;
              if (widget.payments[index].status == "PENDIENTE") {
                colorChip = Colors.red;
              } else if (widget.payments[index].status == "PAGADO") {
                colorChip = Colors.green;
              }
              return DataRow(
                  // color: MaterialStateColor.resolveWith((states) => Styles.backgroundOrange),
                  cells: [
                    DataCell(Center(
                      child:
                          Text(widget.payments[index].paymentOrder.toString()),
                    )),
                    DataCell(Center(
                      child: Text(widget.payments[index].date.toString()),
                    )),
                    DataCell(Center(
                      child: Text(widget.payments[index].payment.toString()),
                    )),
                    DataCell(
                      Chip(
                          backgroundColor: colorChip,
                          label: Text(
                            widget.payments[index].status.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    DataCell(Center(
                      child:
                          Text(widget.payments[index].paymentDate.toString()),
                    )),
                    DataCell(Center(
                      child: Text(widget.payments[index].moraDays.toString()),
                    )),
                    DataCell(Center(
                      child:
                          Text(widget.payments[index].paymentMethod.toString()),
                    )),
                    DataCell(Center(
                      child: Text(
                          widget.payments[index].customerPayment.toString()),
                    )),
                    DataCell(Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showDialogPayment(index,
                                  customerProvider.listPaymentsByCreditId[index]);
                            },
                            child: const Icon(Icons.monetization_on))
                      ],
                    ))
                  ]);
            })),
      ),
    );
  }
}
