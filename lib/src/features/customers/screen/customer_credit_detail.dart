import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/features/credits/widgets/input_credit.dart';
import 'package:del_centro_app/src/providers/customer_provider.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomerCreditDetail extends StatefulWidget {
  const CustomerCreditDetail({Key? key, required this.credit, required this.customer})
      : super(key: key);
  final Credit credit;
  final Customer customer;
  @override
  State<CustomerCreditDetail> createState() => _CustomerCreditDetailState();
}

class _CustomerCreditDetailState extends State<CustomerCreditDetail> {
  late Credit creditData;
  TextEditingController txtCustomerPayment = TextEditingController();
  static const List<String> list = <String>['EFECTIVO', 'DEPOSITO'];
  String dropDownValue = list.first;

  TextStyle style = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  @override
  void initState() {
    creditData = widget.credit;
    Provider.of<CustomerProvider>(context,listen: false).getPaymentsByCreditId(widget.credit.id.toString());
    Provider.of<CustomerProvider>(context,listen: false).getCreditById(widget.credit.id.toString());
    super.initState();
  }

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
                onPressed: ()  async {
                   customerProvider.makePayment(widget.customer.id.toString(),widget.credit.id.toString(),index, payment.id.toString(), dropDownValue, double.parse(txtCustomerPayment.text));
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
    //final creditProvider =  context.watch<CreditProvider>();
    final creditProvider =  context.watch<CustomerProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.name.toString()),
        centerTitle: true,
        backgroundColor: Styles.blueDark,
      ),
      body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                creditProvider.isLoading? const Center(child: CircularProgressIndicator()): Container(
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
                          Text(creditProvider.creditSelected.creditType.toString()),
                          Text(creditProvider.creditSelected.creditAmount.toString()),
                          Text((creditProvider.creditSelected.decimalInterest! * 100).toString()),
                          Text(creditProvider.creditSelected.interestAmount.toString()),
                          Text(creditProvider.creditSelected.totalAmount.toString()),
                          Text(creditProvider.creditSelected.paymentsAmount.toString()),
                          Text(creditProvider.creditSelected.paymentMethod.toString()),
                          Text(creditProvider.creditSelected.mora.toString()),
                          Text(creditProvider.creditSelected.firstPayDate.toString()),
                          Text(creditProvider.creditSelected.expirationDate.toString()),
                          Text(creditProvider.creditSelected.disbursedAmount.toString()),
                          Text(creditProvider.creditSelected.debtAmount.toString()),
                          Text(creditProvider.creditSelected.creditStatus.toString()),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:creditProvider.isLoading ? const Center(child: CircularProgressIndicator()): Card(
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
                          rows: List<DataRow>.generate(creditProvider.listPaymentsByCreditId.length,
                                  (index) {
                                Color colorChip = Colors.grey;
                                if (creditProvider.listPaymentsByCreditId[index].status == "PENDIENTE") {
                                  colorChip = Colors.red;
                                } else if (creditProvider.listPaymentsByCreditId[index].status ==
                                    "PAGADO") {
                                  colorChip = Colors.green;
                                }
                                return DataRow(
                                  // color: MaterialStateColor.resolveWith((states) => Styles.backgroundOrange),
                                    cells: [
                                      DataCell(Center(
                                        child: Text(creditProvider.listPaymentsByCreditId[index]
                                            .paymentOrder
                                            .toString()),
                                      )),
                                      DataCell(Center(
                                        child: Text(creditProvider.listPaymentsByCreditId[index]
                                            .date
                                            .toString()),
                                      )),
                                      DataCell(Center(
                                        child: Text(creditProvider.listPaymentsByCreditId[index]
                                            .payment
                                            .toString()),
                                      )),
                                      DataCell(
                                        Chip(
                                            backgroundColor: colorChip,
                                            label: Text(
                                              creditProvider.listPaymentsByCreditId[index]
                                                  .status
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      DataCell(Center(
                                        child: Text(creditProvider.listPaymentsByCreditId[index]
                                            .paymentDate
                                            .toString()),
                                      )),
                                      DataCell(Center(
                                        child: Text(creditProvider.listPaymentsByCreditId[index]
                                            .moraDays
                                            .toString()),
                                      )),
                                      DataCell(Center(
                                        child: Text(creditProvider.listPaymentsByCreditId[index]
                                            .paymentMethod
                                            .toString()),
                                      )),
                                      DataCell(Center(
                                        child: Text(creditProvider.listPaymentsByCreditId[index]
                                            .customerPayment
                                            .toString()),
                                      )),
                                      DataCell(Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: ()  {
                                                showDialogPayment(index,creditProvider.listPaymentsByCreditId[index]);
                                              },
                                              child: const Icon(
                                                  Icons.monetization_on))
                                        ],
                                      ))
                                    ]);
                              })),
                    ),
                  ),
                )
              ],
            ),
          ),

    );
  }
}
