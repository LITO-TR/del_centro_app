import 'package:flutter/cupertino.dart';


import '../core/models/credit.dart';
import '../core/models/customer.dart';
import '../core/services/credit_service.dart';

class CreditProvider extends ChangeNotifier{
  Credit _creditCreated = Credit();
  bool isLoading = false;

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
    isLoading = true;
    notifyListeners();
  }
}