import 'package:flutter/material.dart';

import '../../../core/models/credit.dart';
import '../../../styles/styles.dart';
class CreditDetail extends StatelessWidget {
  const CreditDetail({Key? key, required this.credit}) : super(key: key);
  final Credit credit;


  final  style = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Styles.backgroundOrange),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'PRODUCTO:  ',
                style: style,
              ),
              Text('MONTO DEL PRESTAMOS:  ', style: style),
              Text('INTERES (%):  ', style: style),
              Text('MONTO INTERES (S/):  ', style: style),
              Text('DEVOLUCION TOTAL:  ', style: style),
              Text('CUOTA:  ', style: style),
              Text('PERIODICIDAD DE PAGO:  ', style: style),
              Text('MORA DIARIA:  ', style: style),
              Text('PRIMER DIA DE PAGO:  ', style: style),
              Text('FECHA DE VENCIMIENTO:  ', style: style),
              Text('MONTO DESEMBOLSADO:  ', style: style),
              Text('DUEDA:  ', style: style),
              Text('ESTADO:  ', style: style)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(credit.creditType.toString()),
              Text(credit.creditAmount.toString()),
              Text((credit.decimalInterest! * 100).toString()),
              Text(credit.interestAmount.toString()),
              Text(credit.totalAmount.toString()),
              Text(credit.paymentsAmount.toString()),
              Text(credit.paymentMethod.toString()),
              Text(credit.mora.toString()),
              Text(credit.firstPayDate.toString()),
              Text(credit.expirationDate.toString()),
              Text(credit.disbursedAmount.toString()),
              Text(credit.debtAmount.toString()),
              Text(credit.creditStatus.toString()),
            ],
          )
        ],
      ),
    );
  }
}
