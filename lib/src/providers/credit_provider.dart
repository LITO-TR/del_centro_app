import 'package:flutter/cupertino.dart';


import '../core/models/credit.dart';
import '../core/models/customer.dart';
import '../core/services/credit_service.dart';

class CreditProvider extends ChangeNotifier{
  Credit _creditCreated = Credit();
  bool isLoading = false;
  List<Credit> _listCreditsByCreationDate = [];

  List<Credit> get listCreditsByCreationDate => _listCreditsByCreationDate;

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

  void getCreditsByCreationDate(String day, String month, String year)async{
    isLoading = true;
    _listCreditsByCreationDate = await CreditService().getCreditsByCreationDate(day, month, year);
    isLoading = false;
    notifyListeners();
  }
}