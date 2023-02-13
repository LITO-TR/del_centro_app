import 'package:del_centro_app/src/core/services/credit_service.dart';
import 'package:del_centro_app/src/core/services/payment_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:del_centro_app/src/features/credits/widgets/input_credit.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';
class BalancePage extends StatefulWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {


   List<String> _othersCosts = [];
  late Future<List<Credit>> _credits;
   late DateTime date;
  late Future<List<Payment>> _payments;
final creditService = CreditService();
final paymentService = PaymentService();
final txtNameCost = TextEditingController();
final txtCost = TextEditingController();
  @override
  void initState() {

    date = DateTime.now();
    _credits = creditService.getCreditsByCreationDate(date.day.toString(), date.month.toString(), date.year.toString());
    _payments = paymentService.getPaymentsByDate(date.day.toString(), date.month.toString(), date.year.toString());
    // TODO: implement initState
    super.initState();
  }

  void showDialogBalance() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Agregar Gasto",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputCredit(name: 'Descripcion de Gasto', controller: txtNameCost, suffix: '', prefix: '', width: 200,type: TextInputType.text),
                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Costo(S/.)', controller: txtCost, suffix: '', prefix: '', width: 200,type: TextInputType.number),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar",style: TextStyle(color: Colors.red),),
              ),
              TextButton(
                onPressed: () {

                  setState(() {
                    _othersCosts.add('${txtNameCost.text} > ${txtCost.text}\n');
                  });
            print(_othersCosts);
            Navigator.of(context).pop();


                },
                child: const Text("Guardar",style: TextStyle(color: Colors.green),),
              )
            ],
          );
        }
    );
  }
  Future<String> getOthersCosts(String words)async{
    final res = await words;
    return res;

  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Balance del dia: (${date.year}/${date.month}/${date.day})',style: TextStyle( fontSize: 30,color: Styles.backgroundOrange,fontWeight: FontWeight.bold),),
              Container(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.height*0.7,

                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green)
                ),
                child: FutureBuilder<List<Credit>>(
                  future: _credits,
                    builder: (context, snapshot){

                 if(snapshot.hasData){
                   List<Credit> listCredit = snapshot.data!;
                   double suma = 0;
                   for(int i = 0; i<listCredit.length; i++){
                     suma += listCredit[i].disbursedAmount!;
                     print(suma);
                   }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(child: Text('${listCredit.length} creditos desembolsados ',style: TextStyle(fontWeight: FontWeight.bold),),),
                      const Icon(Icons.arrow_forward_ios,size: 70,color: Colors.green,),
                      Center(child: Text(suma.toString())),
                    ],
                  );
                 }
                  return const Center(child: CircularProgressIndicator());
                }),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.height*0.7,

                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue)
                ),
                child: FutureBuilder<List<Payment>>(
                    future: _payments,
                    builder: (context, snapshot){

                      if(snapshot.hasData){
                        List<Payment> listPayments = snapshot.data!;
                        double suma = 0;
                        for(int i = 0; i<listPayments.length; i++){
                          suma += listPayments[i].payment!;
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(child: Text('${listPayments.length} pagos programados',style: TextStyle(fontWeight: FontWeight.bold)),),
                            const Icon(Icons.arrow_forward_ios,size: 70,color: Colors.blue,),
                            Center(child: Text(suma.toString())),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.height*0.7,
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red)
                ),
                child: FutureBuilder<List<Payment>>(
                    future: _payments,
                    builder: (context, snapshot){

                      if(snapshot.hasData){
                        List<Payment> listPayments = snapshot.data!;
                        double suma = 0;
                        double deposit = 0;
                        int sizePayment = 0;
                        double money = 0;
                        for(int i = 0; i<listPayments.length; i++){
                          suma += listPayments[i].customerPayment!;
                            if(listPayments[i].paymentMethod == "EFECTIVO"){
                                  sizePayment += 1;
                                money+=listPayments[i].customerPayment!;
                            }else if(listPayments[i].paymentMethod == "DEPOSITO"){
                                  sizePayment += 1;
                                deposit+=listPayments[i].customerPayment!;
                            }
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text('${sizePayment} pagos cobrados',style: TextStyle(fontWeight: FontWeight.bold)),),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,size: 70,color: Colors.red),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text(suma.toString())),
                                Center(child: Text('$money en efectivo'),),
                                Center(child: Text('$deposit en depositos'))

                              ],
                            ),

                          ]
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
           Text(_othersCosts.toString()),

              OutlinedButton.icon(onPressed: (){
                showDialogBalance();
              },icon: const Icon(Icons.add),
                label:  const Text('OTROS GASTOS'),)
            ],
          )
        ),
      ],
    );
  }
}
