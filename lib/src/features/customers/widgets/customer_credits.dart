import 'package:del_centro_app/src/core/api/customer_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/features/customers/widgets/customer_credit_detail.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomerCredits extends StatefulWidget {
  const CustomerCredits({Key? key, required this.customer}) : super(key: key);
  final Customer customer;
  @override
  State<CustomerCredits> createState() => _CustomerCreditsState();
}

class _CustomerCreditsState extends State<CustomerCredits> {
  late Future<List<Credit>> credits;
  final customerService = CustomerService();
  @override
  void initState() {
    // TODO: implement initState
    credits = customerService.getCreditsByCustomer(widget.customer.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: Text(widget.customer.name.toString()),
          centerTitle: true,
          backgroundColor: Styles.blueDark,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    border: Border.all(color: Styles.blueDark)
                ),
              ),
            ),

            FutureBuilder<List<Credit>>(
                future: credits,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    return Container(
                      decoration: const BoxDecoration(),
                      width: MediaQuery.of(context).size.width *1,
                      height: MediaQuery.of(context).size.height *0.6,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                  childAspectRatio: 1.8),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var credit = snapshot.data![index];
                            Color colorStatusCredit = Colors.red;
                            if(credit.creditStatus == "en proceso"){
                               colorStatusCredit = Styles.backgroundOrange;
                            }
                            else if(credit.creditStatus == "finalizado"){
                              colorStatusCredit = Colors.green;
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerCreditDetail(credit: credit,customer: widget.customer,)));
                              },
                              child: Card(
                                elevation: 4,
                                color: Styles.white,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20)),
                                child:    Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(),
                                            child: Column(
                                              children: [
                                                Text(credit.creditAmount.toString(),style: TextStyle(fontSize: 25),),
                                                Text('Monto de credito', style: TextStyle(color: Styles.backgroundOrange),)
                                              ],
                                            ),
                                      ),
                                      Text('${credit.firstPayDate.toString()} -  ${credit.expirationDate.toString()}'),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 30,
                                        decoration: BoxDecoration(

                                         color: colorStatusCredit,
                                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                                        ),
                                        child: Center(child: Text(credit.creditStatus.toString())),
                                      )
                                    ],
                                  ),

                              ),
                            );
                          }),
                    );
                  }
                  return CircularProgressIndicator();
                })
          ],
        ));
  }
}
