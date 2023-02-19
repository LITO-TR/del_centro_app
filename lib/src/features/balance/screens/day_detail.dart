import 'package:del_centro_app/src/core/services/credit_service.dart';
import 'package:del_centro_app/src/features/balance/balance_page.dart';
import 'package:del_centro_app/src/providers/credit_provider.dart';
import 'package:del_centro_app/src/providers/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/customer.dart';

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
   double totalClosed = 0.0;
   double totalPayments = 0.0;
   double totalDisbursed = 0.0;

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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.width*0.9,
            child: SingleChildScrollView(
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
                          return  ListTile(
                            title:  const Text('Cobranzas',style: TextStyle(color: Colors.green),),
                            trailing: Text('TOTAL:  $totalPayments',style: TextStyle(fontWeight: FontWeight.bold),),

                          );
                        },
                        body:
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('Nro Cobros: ${paymentProvider.listPaymentsByDate.length}'),
                              SizedBox(
                                  height:  MediaQuery.of(context).size.height*0.35,
                                    width: MediaQuery.of(context).size.width*0.5,
                                  child: Builder(
                                    builder: (context) {
                                      double totalPaymentsCash = 0;
                                      double totalPaymentsDeposit =0;
                                      totalPayments = 0;
                                      for(int i = 0; i <paymentProvider.listPaymentsByDate.length; i++ ){
                                        if(paymentProvider.listPaymentsByDate[i].paymentMethod == "EFECTIVO"){
                                          totalPaymentsCash += paymentProvider.listPaymentsByDate[i].customerPayment!;
                                        }
                                        if(paymentProvider.listPaymentsByDate[i].paymentMethod == "DEPOSITO"){
                                          totalPaymentsDeposit += paymentProvider.listPaymentsByDate[i].customerPayment!;
                                        }
                                          totalPayments  += paymentProvider.listPaymentsByDate[i].customerPayment!;
                                      }
                                       print(totalPaymentsCash);
                                       print(totalPaymentsDeposit);
                                      return Column(
                                        children: [
                                          Card(
                                            elevation: 5,
                                            child: ListTile(
                                                title: const Text('Efectivo'),
                                                trailing: Text('$totalPaymentsCash'),
                                              ),
                                          ),
                                          Card(
                                            elevation: 5,
                                            child: ListTile(
                                              title: const Text('Deposito'),
                                              trailing: Text('$totalPaymentsDeposit'),
                                            ),
                                          ),
                                        ],
                                      );
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
                          return  ListTile(
                            title: const Text('DESEMBOLSOS',style: TextStyle(color: Colors.red),),
                            trailing: Text('TOTAL: $totalDisbursed ',style: const TextStyle(fontWeight: FontWeight.bold),),

                          );
                        },
                        body: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('Nro Desembolsos: ${creditProvider.listCreditsByCreationDate.length}'),
                              SizedBox(
                                height:  MediaQuery.of(context).size.height*0.35,
                                width: MediaQuery.of(context).size.width*0.5,
                                child: ListView.builder(
                                    itemCount: creditProvider.listCreditsByCreationDate.length,
                                    itemBuilder: (_,index) {

                                      return
                                        Card(
                                          elevation: 5,
                                          child: ListTile(
                                            tileColor: Colors.orange,
                                              title: FutureBuilder<Customer>(
                                                future: CreditService().getCustomerByCreditId(creditProvider.listCreditsByCreationDate[index].id.toString()),
                                                builder: (_,snapshot) {
                                                  if(snapshot.hasData){
                                                    totalDisbursed = 0;
                                                    for(int i = 0; i <creditProvider.listCreditsByCreationDate.length; i++ ){
                                                      totalDisbursed += creditProvider.listCreditsByCreationDate[i].disbursedAmount!;
                                                    }
                                                    return
                                                        Text('${snapshot.data!.name.toString()} ${snapshot.data!.lastName.toString()}');
                                                  }
                                                  return const Center(child: CircularProgressIndicator());

                                                }
                                              ),
                                              trailing: Text('${creditProvider.listCreditsByCreationDate[index].disbursedAmount}')),
                                        );
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
                      ),

                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Builder(
                        builder: (context) {
                          totalClosed = totalDisbursed +totalPayments;
                          return Text('$totalClosed', style: const TextStyle(
                            fontSize: 28
                          ),);
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

