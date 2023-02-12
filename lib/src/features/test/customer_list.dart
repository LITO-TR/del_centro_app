import 'package:del_centro_app/src/core/api/credit_service.dart';
import 'package:del_centro_app/src/core/api/customer_service.dart';
import 'package:del_centro_app/src/features/test/test_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/customer.dart';

class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget(
      {super.key,
      required super.child,
      required this.customerService,
      required this.creditService});
  static MyInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  final CustomerService customerService;
  final CreditService creditService;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class Hola extends StatefulWidget {
  const Hola({Key? key}) : super(key: key);

  @override
  State<Hola> createState() => _HolaState();
}

class _HolaState extends State<Hola> {
  @override
  void initState() {
    final customerProvider = Provider.of<TestProvider>(context, listen: false);
    customerProvider.getCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = context.watch<TestProvider>();
    return Row(
      children: [
        SizedBox(
          width: 300,
          height: 700,
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 600,
                child: Consumer<TestProvider>(
                  builder: (_, snapshot,__) {
                    return ListView.builder(
                      itemCount: snapshot.customerList.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            Text(snapshot.customerList[index].name.toString()),
                            Text(snapshot.customerList.length.toString()),

                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(onPressed: () {

                var customer1 = Customer(name: 'yyyy', lastName:'ssssss', address: 'sdasda', dni: 'ggggggg', civilStatus: 'ggggg', phoneNumber:'asdasdas');
                customerProvider.addCustomer(customer1);
                customerProvider.getCustomers();

              }, child: Text('Agregar'))
            ],
          ),
        ),
      ],
    );
  }
}
