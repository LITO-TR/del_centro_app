import 'package:del_centro_app/src/core/api/customer_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/features/credit/widgets/input_credit.dart';
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
  late Future<List<Customer>> _customers;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtDNI = TextEditingController();
  TextEditingController txtCivilStatus = TextEditingController();


  final customerService = CustomerService();
  int n = 0;
  List<Credit> creditsList = [];
  @override
  void initState() {
    // TODO: implement initState
    _customers = customerService.getAllCustomers();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //creditsList.clear();
    super.dispose();
  }
  void showForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: const Text("Registrar Ciente",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputCredit(name: 'Nombres', controller: txtName, suffix: '', prefix: '', width: 300),
                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Apellidos', controller: txtLastName, suffix: '', prefix: '', width: 300),
                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'DNI', controller: txtDNI, suffix: '', prefix: '', width: 300),

                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Direccion', controller: txtAddress, suffix: '', prefix: '', width: 300),

                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Cell', controller: txtPhoneNumber, suffix: '', prefix: '', width: 300),

                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Estado Civil', controller: txtCivilStatus, suffix: '', prefix: '', width: 300),
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
                onPressed: () async{
                  Customer customer = Customer(name: txtName.text, lastName: txtLastName.text, address: txtAddress.text, dni: txtDNI.text, civilStatus: txtCivilStatus.text, phoneNumber: txtPhoneNumber.text);
                     await customerService.registerCustomer(customer);
                    setState(() {
                      _customers = customerService.getAllCustomers();
                    });
                    print(_customers);

                  Navigator.of(context).pop();


                },
                child: const Text("Guardar",style: TextStyle(color: Colors.green),),
              )
            ],
          );
        }
        );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
                  child:Container(
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
                future: _customers,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      decoration: const BoxDecoration(),
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height *0.8,
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerCredits(customer: customer)));
                              },
                              child: Card(
                                elevation: 4,
                                color: Styles.white,
                                shape: RoundedRectangleBorder(
                                    side:
                                        const BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${customer.name} ',
                                            style: TextStyle(
                                                color: Styles.blueDark,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            customer.lastName.toString(),
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
                                                    const Icon(
                                                      Icons.credit_card_outlined,
                                                      color: Colors.blue,
                                                    ),
                                                    Text(
                                                      customer.dni.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.call,
                                                      color: Colors.green,
                                                    ),
                                                    Text(
                                                      customer.phoneNumber.toString(),
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                          SizedBox(
                                            child: FutureBuilder<List<Credit>>(
                                              future: customerService.getCreditsByCustomer(
                                                  customer.id.toString()),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<Credit> credits =
                                                      snapshot.data!;
                                                  creditsList = credits;
                                                  IconData icon =
                                                      Icons.check_circle;
                                                  Color color = Colors.black;
                                                  if (credits.length >= 8) {
                                                    icon = Icons.emoji_events;
                                                    color = Colors.amberAccent;
                                                  } else if (credits.length < 8 && credits.isNotEmpty) {
                                                    icon = Icons
                                                        .emoji_emotions_outlined;
                                                    color = Colors.deepPurple;
                                                  }
                                                  else if(credits.length == 0){
                                                    icon = Icons.child_care;
                                                    color = Colors.teal;
                                                  }
                                                  return Column(
                                                    children: [
                                                      Text(
                                                        '${credits.length} Creditos',
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                Icon(icon, color: color,size: 30,)
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
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            elevation: 10,
            onPressed: (){
              showForm();
              // return const CustomerRegisterDialog(customers: _customers,);
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,

          ),
        )
      ],
    );
  }
}
