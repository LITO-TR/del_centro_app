import 'dart:ffi';

import 'package:del_centro_app/src/features/credit/widgets/input_credit.dart';
import 'package:flutter/material.dart';

class CreditPage extends StatefulWidget {
  const CreditPage({Key? key}) : super(key: key);

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {

  static const  List<String> list = <String>['DIARIO', 'SEMANAL', 'QUINCENAL'];
  final  test = TextEditingController();
  final  txtCreditAmount = TextEditingController();
  final  txtInterest = TextEditingController();
  final  txtNumberOfPayments = TextEditingController();
  double creditAmount = 0.0;
  double interest = 0.0;
  double numberOfPayments = 0.0;
  String txtTotalAmount = '0.0';
  String txtPayment = '0.0';
  double ab = 0.0;
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController3 = TextEditingController();

  String dropDownValue = list.first;

  @override
  void initState() {
    // TODO: implement initState

    // creditAmount = double.parse(txtCreditAmount.text);
    // interest = double.parse(txtInterest.text);
    // numberOfPayments = double.parse(txtNumberOfPayments.text);
    myController.addListener(_plus);
    myController1.addListener(_plus);
    myController3.addListener(_plus);
    super.initState();
  }

  _plus(){

    setState(() {
      if(myController.text.isEmpty){
        ab = double.parse(myController1.text)+ 0 ;
      }
      else if(myController1.text.isEmpty){
        ab = double.parse(myController.text)+ 0;
      }
      ab = double.parse(myController.text) + double.parse(myController1.text);

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
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                   Text('DATOS DEL CREDITO')
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
                      color: Colors.grey,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Total: S/${txtTotalAmount}'),
                        Text('Cuota: S/${txtPayment}')
                      ],
                    ),
                  )
                 ],
              ),
              ElevatedButton(
                  onPressed: () {
                    double totalAmount = 0.0;
                    double payment = 0.0;
                    setState(() {
                      totalAmount = creditAmount + creditAmount * interest / 100;
                      payment = totalAmount / numberOfPayments;
                      txtTotalAmount = totalAmount.toString();
                      txtPayment = payment.toString();
                    });
                  },
                  child: const Text('Simular Credito')
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const[
                     Text('DATOS DEL CLIENTE'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InputCredit(
                      name: 'Nombres',
                      controller: test,
                      suffix: '',
                      prefix: '',
                      width: 220),
                  InputCredit(
                      name: 'Apellidos',
                      controller: test,
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
                      controller: test,
                      suffix: '',
                      prefix: '',
                      width: 100),
                  InputCredit(
                      name: 'Dirección',
                      controller: test,
                      suffix: '',
                      prefix: '',
                      width: 350),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              Container(
                width: 200,
                child: DropdownButtonFormField(
                    value: dropDownValue,
                    decoration: InputDecoration(

                      border: const OutlineInputBorder(),

                    ),
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        dropDownValue = value!;
                      });
                    }


                ),
              ),

              ElevatedButton(onPressed: (){}, child:  const Text('Crear Credito'))
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 1.05,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
             /*FutureBuilder(
                future: ,
                builder: (context,  snapshot) {

              },
              ),*/
              TextField(
                controller: myController1,
              ),
              TextField(
                controller: myController,

              ),
              Text(ab.toString()),
            ],
          ),
        ),
      ],
    );
  }
}
