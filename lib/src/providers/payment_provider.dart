import 'package:del_centro_app/src/core/services/payment_service.dart';
import 'package:flutter/cupertino.dart';

class PaymentProvider extends ChangeNotifier{
  bool isLoading = false;
  void makePayment(String paymentId, String method, double customerPayment)async{
    isLoading = true;
    await PaymentService().setPayment(paymentId, method, customerPayment);
    notifyListeners();
  }

}