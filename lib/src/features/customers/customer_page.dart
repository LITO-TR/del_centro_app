import 'package:del_centro_app/src/core/services/customer_service.dart';
import 'package:del_centro_app/src/features/credits/widgets/input_credit.dart';
import 'package:del_centro_app/src/features/customers/screen/customer_credits.dart';
import 'package:del_centro_app/src/features/customers/widgets/customer_card.dart';
import 'package:del_centro_app/src/features/test/test_provider.dart';
import 'package:flutter/material.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:provider/provider.dart';


class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final txtName = TextEditingController();
  final txtLastName = TextEditingController();
  final txtAddress = TextEditingController();
  final txtPhoneNumber = TextEditingController();
  final txtDNI = TextEditingController();
  final txtCivilStatus = TextEditingController();
  final customerService = CustomerService();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<TestProvider>(context,listen: false).getCustomers();
    super.initState();
  }
  void showForm() {
    showDialog(
        context: context,
        builder: (context) {
          final customerProvider = context.watch<TestProvider>();
          return AlertDialog(
            title: const Center(child: Text("Registrar Ciente",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputCredit(name: 'Nombres', controller: txtName, suffix: '', prefix: '', width: 300,type: TextInputType.text),
                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Apellidos', controller: txtLastName, suffix: '', prefix: '', width: 300,type: TextInputType.text),
                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'DNI', controller: txtDNI, suffix: '', prefix: '', width: 300,type: TextInputType.number),

                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Direccion', controller: txtAddress, suffix: '', prefix: '', width: 300,type: TextInputType.text),

                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Cell', controller: txtPhoneNumber, suffix: '', prefix: '', width: 300,type: TextInputType.number),

                  const SizedBox(
                    height: 15,
                  ),
                  InputCredit(name: 'Estado Civil', controller: txtCivilStatus, suffix: '', prefix: '', width: 300,type: TextInputType.text),
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
                  Customer customer = Customer(name: txtName.text, lastName: txtLastName.text, address: txtAddress.text, dni: txtDNI.text, civilStatus: txtCivilStatus.text, phoneNumber: txtPhoneNumber.text);
                  customerProvider.addCustomer(customer);
                  customerProvider.getCustomers();
                  txtName.clear();
                  txtLastName.clear();
                  txtAddress.clear();
                  txtDNI.clear();
                  txtCivilStatus.clear();
                  txtPhoneNumber.clear();
                  Navigator.of(context).pop();
                },
                child: const Text("Registrar",style: TextStyle(color: Colors.green),),
              )
            ],
          );
        }
        );
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = context.watch<TestProvider>();
    return ListView(
        children: [
          Stack(
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
                   Container(
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
                              itemCount: customerProvider.customerList.length,
                              itemBuilder: (context, index) {
                                if(customerProvider.isLoading){
                                  return const Center(child: CircularProgressIndicator());
                                }
                                var customer = customerProvider.customerList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerCredits(customer: customer)));
                                  },
                                  child:CustomerCard(customer: customer),

                                );
                              }
                              )

                  ),
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
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),

                ),
              )
            ],
          ),
        ],
      );
  }
}
