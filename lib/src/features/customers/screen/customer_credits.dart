
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/features/customers/screen/customer_credit_detail.dart';
import 'package:del_centro_app/src/features/customers/widgets/credit_card.dart';
import 'package:del_centro_app/src/providers/customer_provider.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerCredits extends StatefulWidget {
  const CustomerCredits({Key? key, required this.customer}) : super(key: key);
  final Customer customer;
  @override
  State<CustomerCredits> createState() => _CustomerCreditsState();
}

class _CustomerCreditsState extends State<CustomerCredits> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CustomerProvider>(context, listen: false)
        .getCreditsByCustomerId(widget.customer.id.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final customerProvider = context.watch<CustomerProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.customer.name.toString()),
          centerTitle: true,
          backgroundColor: Styles.blueDark,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Styles.blueDark)),
                    child: const Center(
                      child: Text('Datos del cliente'),
                    ),
                  ),
                ),
               customerProvider.isLoading ?const Center(child: CircularProgressIndicator()): Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                              childAspectRatio: 1.8),
                      itemCount: customerProvider.listCreditsByCustomer.length,
                      itemBuilder: (context, index) {
                        var credit = customerProvider.listCreditsByCustomer[index];
                        Color colorStatusCredit = Colors.red;
                       if (customerProvider.listCreditsByCustomer[index].creditStatus == "en proceso") {
                         colorStatusCredit = Styles.backgroundOrange;
                        } else if (customerProvider.listCreditsByCustomer[index].creditStatus ==
                            "finalizado") {
                         colorStatusCredit = Colors.green;
                       }
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerCreditDetail(
                                            credit: customerProvider.listCreditsByCustomer[index],
                                            customer: widget.customer,
                                          )));
                            },
                            child: CreditCard(
                              credit: credit,
                              color: colorStatusCredit,
                            ));
                      }),
                ),
              ],
            ),
          ],
        ));
  }
}


