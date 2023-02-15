import 'package:del_centro_app/src/core/services/credit_service.dart';
import 'package:flutter/cupertino.dart';

import '../core/models/credit.dart';
import '../core/models/customer.dart';

class CreditProvider extends ChangeNotifier{
  Credit _creditCreated = Credit();
  bool isLoading = true;

  Credit get creditCreated => _creditCreated;

  void createCredit(
      double creditAmount,
      double decimalInterest,
      int numberOfPayments,
      String paymentMethod,
      double mora,
      Customer customer) async{
    isLoading = false;
    _creditCreated = await CreditService().createCredit(creditAmount, decimalInterest, numberOfPayments, paymentMethod, mora, customer);

    notifyListeners();
  }


}