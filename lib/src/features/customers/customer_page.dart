import 'package:del_centro_app/src/core/api/customer_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/features/customers/widgets/customer_credits.dart';
import 'package:flutter/material.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/styles/styles.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late Future<List<Customer>> customers;
  late Future<List<Credit>> credits;

  final service = CustomerService();
  int n = 0;
  List<Credit> creditsList = [];
  @override
  void initState() {
    // TODO: implement initState
    customers = service.getAllCustomers();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //creditsList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Styles.white,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ),
        FutureBuilder<List<Customer>>(
            future: customers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 1.13,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                              childAspectRatio: 2.7),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var customer = snapshot.data![index];

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerCredits(customer: customer)));

                          },
                          child: Card(
                            elevation: 4,
                            color: Styles.white,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${customer.name} ',
                                        style: TextStyle(
                                            color: Styles.blueDark,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        customer.lastName,
                                        style: TextStyle(
                                            color: Styles.backgroundOrange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.credit_card_outlined,color: Colors.blue,),
                                                Text(customer.dni,style: const TextStyle(color: Colors.grey),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.call,color: Colors.green,),
                                                Text(customer.phoneNumber,style: TextStyle(color: Colors.grey),),
                                              ],
                                            )
                                          ]),
                                      SizedBox(
                                        child: FutureBuilder<List<Credit>>(
                                          future:service.getCreditsByCustomer(customer.id),
                                          builder: ( context,  snapshot) {
                                            if(snapshot.hasData){
                                              List<Credit> credits = snapshot.data!;
                                              creditsList = credits;
                                              IconData icon = Icons.check_circle;
                                              if(credits.length > 5){
                                                icon = Icons.diamond;
                                              }
                                              else if(credits.length<5){
                                                icon = Icons.check_circle_outline_outlined;
                                              }
                                              return
                                                Column(
                                                  children: [
                                                    Text(
                                                      '${credits.length} Creditos',
                                                      style: const TextStyle(color: Colors.grey),
                                                    ),
                                                    const Chip(label:
                                                    Icon(Icons.diamond)
                                                    )
                                                  ],
                                                );
                                            }
                                            return const CircularProgressIndicator();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ],
    );
  }
}
