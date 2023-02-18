import 'package:del_centro_app/src/core/services/payment_service.dart';
import 'package:flutter/cupertino.dart';

import '../core/models/payment.dart';

class PaymentProvider extends ChangeNotifier{
  List<Payment> _listPaymentsByDate = [];

  List<Payment> get listPaymentsByDate => _listPaymentsByDate;
  bool isLoading = false;



  void getPaymentsByDate(String day, String month, String year)async{
    isLoading = true;
    _listPaymentsByDate = await PaymentService().getPaymentsByDate(day, month, year);
    isLoading = false;
    notifyListeners();

  }

  void makePaymentDaily(int index,String paymentId, String method, double customerPayment)async{
    isLoading = true;
    _listPaymentsByDate[index] = await PaymentService().setPayment(paymentId, method, customerPayment);
    isLoading = false;
    notifyListeners();
  }





}