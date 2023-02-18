import 'package:del_centro_app/src/features/balance/balance_page.dart';
import 'package:del_centro_app/src/providers/credit_provider.dart';
import 'package:del_centro_app/src/providers/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayDetail extends StatefulWidget {
  const DayDetail({Key? key, required this.objMonth, required this.day})
      : super(key: key);
  final MONTHS objMonth;
  final int day;
  @override
  State<DayDetail> createState() => _DayDetailState();
}

class _DayDetailState extends State<DayDetail> {

   List<bool> isExpandedList = [false,false,false,false,false];

   @override
  void initState() {

     Provider.of<PaymentProvider>(context, listen: false).getPaymentsByDate(widget.day.toString(), widget.objMonth.id.toString(), widget.objMonth.year.toString());
     Provider.of<CreditProvider>(context, listen: false).getCreditsByCreationDate(widget.day.toString(), widget.objMonth.id.toString(), widget.objMonth.year.toString());
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.watch<PaymentProvider>();
    final creditProvider = context.watch<CreditProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.day.toString()} de ${widget.objMonth.name}'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
          ),
          child: Column(
            children: [
              ExpansionPanelList(
                expansionCallback: (index, isExpanded){
                  setState(() {
                    isExpandedList[index] = !isExpanded;
                  });
                  },
                children: [
                  ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return const ListTile(
                          title:  Text('Dia Anterior(fecha)',style: TextStyle(color: Colors.blue),),
                          trailing: Text('TOTAL: ',style: TextStyle(fontWeight: FontWeight.bold),),
                        );
                        
                        },
                      body: const ListTile(title:  Text('aaaaaaaaaaaa'),),
                      isExpanded: isExpandedList[0],
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title:  Text('Bancos',style: TextStyle(color: Colors.green),),
                        trailing: Text('TOTAL: ',style: TextStyle(fontWeight: FontWeight.bold),),

                      );
                    },
                    body: const ListTile(title:  Text('ASDASD'),),
                    isExpanded: isExpandedList[1]
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title:  Text('Cobranzas',style: TextStyle(color: Colors.green),),
                        trailing: Text('TOTAL: ',style: TextStyle(fontWeight: FontWeight.bold),),

                      );
                    },
                    body:
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Nro Cobros: ${paymentProvider.listPaymentsByDate.length}'),
                          SizedBox(
                              height:  MediaQuery.of(context).size.height*0.35,
                                width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemCount: paymentProvider.listPaymentsByDate.length,
                                itemBuilder: (_,index) {
                                  // var paymentsCash = paymentProvider.listPaymentsByDate[index]
                                  // var paymentsDeposit = paymentProvider.listPaymentsByDate.where((payment) => payment.paymentMethod == 'DEPOSITO');
                                  return
                                      ListTile(
                                          title: Text(paymentProvider.listPaymentsByDate[index].id.toString()),
                                          trailing: Text('${paymentProvider.listPaymentsByDate[index].customerPayment}'));

                                }
                              ),
                              ),
                        ],
                      ),
                    ),


                    isExpanded: isExpandedList[2]
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title:  Text('DESEMBOLSOS',style: TextStyle(color: Colors.red),),
                        trailing: Text('TOTAL: ',style: TextStyle(fontWeight: FontWeight.bold),),

                      );
                    },
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Nro Desembolsos: ${creditProvider.listCreditsByCreationDate.length}'),
                          SizedBox(
                            height:  MediaQuery.of(context).size.height*0.35,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: creditProvider.listCreditsByCreationDate.length,
                                itemBuilder: (_,index) {
                                  // var paymentsCash = paymentProvider.listPaymentsByDate[index]
                                  // var paymentsDeposit = paymentProvider.listPaymentsByDate.where((payment) => payment.paymentMethod == 'DEPOSITO');
                                  return
                                    ListTile(
                                        title: Text(creditProvider.listCreditsByCreationDate[index].id.toString()),
                                        trailing: Text('${creditProvider.listCreditsByCreationDate[index].disbursedAmount}'));

                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: isExpandedList[3]
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title:  Text('GASTOS',style: TextStyle(color: Colors.red),),
                        trailing: Text('TOTAL: ',style: TextStyle(fontWeight: FontWeight.bold),),

                      );
                    },
                    body: const ListTile(title:  Text('ASDASD'),),
                    isExpanded: isExpandedList[4]
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}

