import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:del_centro_app/src/features/customers/widgets/credit_detail.dart';
import 'package:del_centro_app/src/features/customers/widgets/payments_data_table.dart';
import 'package:del_centro_app/src/providers/customer_provider.dart';
import 'package:del_centro_app/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerCreditDetail extends StatefulWidget {
  const CustomerCreditDetail(
      {Key? key, required this.credit, required this.customer})
      : super(key: key);
  final Credit credit;
  final Customer customer;
  @override
  State<CustomerCreditDetail> createState() => _CustomerCreditDetailState();
}

class _CustomerCreditDetailState extends State<CustomerCreditDetail> {
  TextStyle style =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  void initState() {
    Provider.of<CustomerProvider>(context, listen: false)
        .getPaymentsByCreditId(widget.credit.id.toString());
    Provider.of<CustomerProvider>(context, listen: false)
        .getCreditById(widget.credit.id.toString());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final creditProvider = context.watch<CustomerProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.name.toString()),
        centerTitle: true,
        backgroundColor: Styles.blueDark,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            creditProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : CreditDetail(credit: creditProvider.creditSelected),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: creditProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PaymentsDataTable(
                     // payments: creditProvider.listPaymentsByCreditId,
                      payments: creditProvider.listPaymentsByCreditId,
                  customer: widget.customer,
                      credit: widget.credit),
            )
          ],
        ),
      ),
    );
  }
}
