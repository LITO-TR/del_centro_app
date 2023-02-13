import 'package:del_centro_app/src/core/services/credit_service.dart';
import 'package:del_centro_app/src/core/services/customer_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/features/credits/widgets/input_credit.dart';
import 'package:del_centro_app/src/features/shared/widgets/button_with_icon.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';

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
  Future<Credit>? creditCreated;
  final service = CreditService();
  late Customer customerSelected;

  late Future<List<Customer>> _customers;
  final customerService = CustomerService();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _customers = customerService.getAllCustomers();
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.green,
                        ),
                        Text(
                          'CREDITO',
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
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
                              type: TextInputType.number,),
                          InputCredit(
                              name: 'Interes',
                              controller: txtInterest,
                              suffix: '%',
                              prefix: '',
                              width: 120,
                            type: TextInputType.number,),
                          InputCredit(
                              name: 'Cuotas',
                              controller: txtNumberOfPayments,
                              suffix: '',
                              prefix: '',
                              width: 120,
                            type: TextInputType.number,),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.table_view,
                                color: Colors.green,
                              ),
                              Text(
                                'SIMULADOR',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
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
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        items: list.map<DropdownMenuItem<String>>((String value) {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        Text(
                          'CLIENTE',
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: FutureBuilder(
                        future: _customers,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Customer> customer = snapshot.data!;
                            return ListView.builder(
                                itemCount: customer.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(customer[index].name.toString()),
                                    subtitle:
                                        Text(customer[index].lastName.toString()),
                                    leading: const Icon(Icons.person),
                                    selected: index == _selectedIndex,
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                      customerSelected = customer[index];

                                    },
                                  );
                                });
                          }
                          return const Center(child: CircularProgressIndicator());
                        }),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonWithIcon(
                        color: Colors.green,
                        iconData: Icons.check,
                        label: 'CREAR',
                        onPressed: () {
                          setState(() {
                            creditCreated = service.createCredit(
                                double.parse(txtCreditAmount.text),
                                double.parse(txtInterest.text) / 100,
                                int.parse(txtNumberOfPayments.text),
                                dropDownValue,
                                0.5,
                                customerSelected);
                              txtCreditAmount.clear();
                              txtInterest.clear();
                              txtNumberOfPayments.clear();

                          });
                        },
                      )),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 1.05,
              decoration: BoxDecoration(
                  color: Styles.white, borderRadius: BorderRadius.circular(10)),
              child: FutureBuilder(
                future: creditCreated,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var credit = snapshot.data!;
                    return Column(
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        size: 40,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                customerSelected.name.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                ' ${customerSelected.lastName.toString()}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text('DNI: ${customerSelected.dni.toString()}'),
                                          Text('CEL: ${customerSelected.phoneNumber.toString()}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'S/ ${credit.creditAmount}',
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      Text(
                                        'Monto del Credito',
                                        style: TextStyle(
                                            color: Styles.backgroundOrange),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'S/. ${credit.paymentsAmount.toString()}',
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      Text(
                                        'Couta ',
                                        style: TextStyle(
                                            color: Styles.backgroundOrange),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${((credit.decimalInterest! * 100).toStringAsFixed(2))} %',
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      Text(
                                        'Interes',
                                        style: TextStyle(
                                            color: Styles.backgroundOrange),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'S/ ${credit.totalAmount}',
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      Text(
                                        'Devolucion Total',
                                        style: TextStyle(
                                            color: Styles.backgroundOrange),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        credit.numberOfPayments.toString(),
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      Text(
                                        'Numero de Cuotas ',
                                        style: TextStyle(
                                            color: Styles.backgroundOrange),
                                      ),
                                    ],
                                  ),
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Primer dia de Pago:  ',
                                            style: TextStyle(
                                              color: Styles.blueDark,
                                            ),
                                          ),
                                          Text(
                                            credit.firstPayDate.toString(),
                                            style: TextStyle(
                                                color: Styles.blueDark,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Ultimo dia de Pago:  ',
                                            style: TextStyle(
                                              color: Styles.blueDark,
                                            ),
                                          ),
                                          Text(
                                            credit.expirationDate.toString(),
                                            style: TextStyle(
                                                color: Styles.blueDark,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
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
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Creando credito'),
                      CircularProgressIndicator()
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}