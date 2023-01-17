import 'package:del_centro_app/src/features/credit/widgets/input_credit.dart';
import 'package:del_centro_app/src/features/shared/widgets/button_with_icon.dart';
import 'package:flutter/material.dart';

class CreditPage extends StatefulWidget {
  const CreditPage({Key? key}) : super(key: key);

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  static const List<String> list = <String>['DIARIO', 'SEMANAL', 'QUINCENAL'];
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

  @override
  void initState() {
    // TODO: implement initState

    txtCreditAmount.addListener(_getPaymentsAndTotal);
    txtNumberOfPayments.addListener(_getPaymentsAndTotal);
    txtInterest.addListener(_getPaymentsAndTotal);
    super.initState();
  }
  @override
  void dispose(){
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
        payments = totalAmount / double.parse(txtNumberOfPayments.text);
      }
    });
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 1.05,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [Text('DATOS DEL CREDITO')],
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
                          width: 120),
                      InputCredit(
                          name: 'Interes',
                          controller: txtInterest,
                          suffix: '%',
                          prefix: '',
                          width: 120),
                      InputCredit(
                          name: 'Cuotas',
                          controller: txtNumberOfPayments,
                          suffix: '',
                          prefix: '',
                          width: 120),
                    ],
                  ),
                  Container(
                    width: 150,
                    height: 75,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        //border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Total: S/$totalAmount'),
                        Text('Cuota: S/$payments')
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text('DATOS DEL CLIENTE'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InputCredit(
                      name: 'Nombres',
                      controller: txtName,
                      suffix: '',
                      prefix: '',
                      width: 220),
                  InputCredit(
                      name: 'Apellidos',
                      controller: txtLastName,
                      suffix: '',
                      prefix: '',
                      width: 220),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InputCredit(
                      name: 'DNI',
                      controller: txtDNI,
                      suffix: '',
                      prefix: '',
                      width: 100),
                  InputCredit(
                      name: 'Dirección',
                      controller: txtAddress,
                      suffix: '',
                      prefix: '',
                      width: 350),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 150,
                child: DropdownButtonFormField(
                    value: dropDownValue,
                    decoration: const InputDecoration(
                      border:  OutlineInputBorder(
                        borderSide: BorderSide.none
                      ),
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
                padding: const EdgeInsets.all(20.0),
                child: ButtonWithIcon(
                  color: Colors.green,
                  iconData: Icons.check,
                  label: 'CREAR',
                  onPressed: (){},

                )

              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 1.05,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: const [
              /*FutureBuilder(
                future: ,
                builder: (context,  snapshot) {

              },
              ),*/

            ],
          ),
        ),
      ],
    );
  }
}
