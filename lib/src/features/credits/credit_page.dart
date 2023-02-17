import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/features/credits/widgets/credit_property_names.dart';
import 'package:del_centro_app/src/features/credits/widgets/days_payments.dart';
import 'package:del_centro_app/src/features/credits/widgets/input_credit.dart';
import 'package:del_centro_app/src/features/customers/widgets/titles_credits.dart';
import 'package:del_centro_app/src/features/shared/widgets/button_with_icon.dart';
import 'package:del_centro_app/src/providers/credit_provider.dart';
import 'package:del_centro_app/src/providers/customer_provider.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreditPage extends StatefulWidget {
  const CreditPage({Key? key}) : super(key: key);

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  int _selectedIndex = 0;

  static const List<String> list = <String>['day', 'week', 'QUINCENAL'];
  final txtCreditAmount = TextEditingController();
  final txtInterest = TextEditingController();
  final txtNumberOfPayments = TextEditingController();
  final txtName = TextEditingController();
  final txtLastName = TextEditingController();
  final txtDNI = TextEditingController();
  final txtAddress = TextEditingController();
  double totalAmount = 0.0;
  double payments = 0.0;
  String dropDownValue = list.first;
  late Customer _customerSelected;
  @override
  void initState() {
    super.initState();
    Provider.of<CustomerProvider>(context, listen: false).getCustomers();
    _customerSelected = Customer();
    txtCreditAmount.addListener(_getPaymentsAndTotal);
    txtNumberOfPayments.addListener(_getPaymentsAndTotal);
    txtInterest.addListener(_getPaymentsAndTotal);
  }

  @override
  void dispose() {
    super.dispose();
    txtCreditAmount.removeListener(_getPaymentsAndTotal);
    txtNumberOfPayments.removeListener(_getPaymentsAndTotal);
    txtInterest.removeListener(_getPaymentsAndTotal);
  }

  _getPaymentsAndTotal() {
    setState(() {
      if (txtNumberOfPayments.text.isEmpty ||
          txtCreditAmount.text.isEmpty ||
          txtInterest.text.isEmpty) {
        totalAmount = 0.0;
        payments = 0.0;
      } else {
        totalAmount = double.parse(txtCreditAmount.text) +
            (double.parse(txtCreditAmount.text) *
                double.parse(txtInterest.text) /
                100);
        payments = totalAmount / int.parse(txtNumberOfPayments.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final creditProvider = context.watch<CreditProvider>();
    final customerProvider = context.watch<CustomerProvider>();
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 1.05,
              decoration: BoxDecoration(
                  color: Styles.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TitlesCredits(
                        icon: Icons.monetization_on,
                        title: 'CREDITO',
                        fontSize: 18,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InputCredit(
                            name: 'Monto Credito',
                            controller: txtCreditAmount,
                            suffix: '.00',
                            prefix: 'S/.',
                            width: 120,
                            type: TextInputType.number,
                          ),
                          InputCredit(
                            name: 'Interes',
                            controller: txtInterest,
                            suffix: '%',
                            prefix: '',
                            width: 120,
                            type: TextInputType.number,
                          ),
                          InputCredit(
                            name: 'Cuotas',
                            controller: txtNumberOfPayments,
                            suffix: '',
                            prefix: '',
                            width: 120,
                            type: TextInputType.number,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const TitlesCredits(
                            icon: Icons.table_view,
                            title: 'SIMULADOR',
                            fontSize: 15,
                          ),
                          Container(
                            width: 150,
                            height: 75,
                            decoration: BoxDecoration(
                                color: Styles.blueDark,
                                //border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total: S/${totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Cuota: S/${payments.toStringAsFixed(2)}',
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
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
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TitlesCredits(
                        icon: Icons.person,
                        title: 'CLIENTE',
                        fontSize: 18,
                      )),
                  Container(
                    width: 250,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListView.builder(
                        itemCount: customerProvider.customerList.length,
                        itemBuilder: (context, index) {
                          if (customerProvider.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ListTile(
                            title: Text(customerProvider
                                .customerList[index].name
                                .toString()),
                            subtitle: Text(customerProvider
                                .customerList[index].lastName
                                .toString()),
                            leading: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            selected: index == _selectedIndex,
                            selectedColor: Colors.green,
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.red,
                              ),
                              onPressed: () {},
                            ),
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                              _customerSelected = customerProvider.customerList[index];

                              },
                          );
                        }),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonWithIcon(
                        color: Colors.green,
                        iconData: Icons.check,
                        label: 'CREAR',
                        onPressed: () {
                          customerProvider.setCustomerSelected(_customerSelected);
                            creditProvider.createCredit(
                                double.parse(txtCreditAmount.text),
                                double.parse(txtInterest.text) / 100,
                                int.parse(txtNumberOfPayments.text),
                                dropDownValue,
                                0.5,
                                customerProvider.getCustomerSelected());
                            txtCreditAmount.clear();
                            txtInterest.clear();
                            txtNumberOfPayments.clear();
                        },
                      )),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 1.05,
                decoration: BoxDecoration(
                    color: Styles.white,
                    borderRadius: BorderRadius.circular(10)),
                child:
                creditProvider.isLoading
                    ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                          color: Styles.blueDark,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Styles.scaffoldBackgroundColor,
                              ),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.person_outline,
                                    size: 40,
                                  ),
                                  Consumer<CustomerProvider>(
                                    builder: (_,snapshot,__) {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.getCustomerSelected().name.toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text(
                                                snapshot.getCustomerSelected().lastName.toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(
                                              'DNI: ${snapshot.getCustomerSelected().dni.toString()}'),
                                          Text(
                                              'CEL: ${snapshot.getCustomerSelected().phoneNumber.toString()}'),
                                        ],
                                      );
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              CreditPropertiesNames(title: 'Monto de Credito', value: creditProvider.creditCreated.creditAmount.toString()),
                              CreditPropertiesNames(title: 'Cuota', value: creditProvider.creditCreated.paymentsAmount.toString()),
                              CreditPropertiesNames(title: 'Interes', value: '${creditProvider.creditCreated.decimalInterest==null? 'O' :((creditProvider.creditCreated.decimalInterest!*100).toStringAsFixed(2))} %'),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              CreditPropertiesNames(title: 'Devolucion Total', value: creditProvider.creditCreated.totalAmount.toString()),
                              CreditPropertiesNames(title: 'Numero de Cuotas', value:  creditProvider
                                  .creditCreated.numberOfPayments
                                  .toString()),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Styles.backgroundOrange,
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  DaysPayments(title:  'Primer dia de Pago:  ', value: creditProvider
                                      .creditCreated.firstPayDate
                                      .toString()),
                                  DaysPayments(title:  'Ultimo dia de Pago:  ', value: creditProvider
                                      .creditCreated.firstPayDate
                                      .toString()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonWithIcon(
                          color: Colors.green,
                          iconData: Icons.print,
                          onPressed: () {},
                          label: 'CONTRATO'),
                    )
                  ],
                ):  const Center(child: CircularProgressIndicator())
            ),
          ],
        ),
      ],
    );
  }
}
