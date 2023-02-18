import 'package:flutter/material.dart';

import '../core/models/credit.dart';
import '../core/models/customer.dart';
import '../core/models/payment.dart';
import '../core/services/credit_service.dart';
import '../core/services/customer_service.dart';
import '../core/services/payment_service.dart';
class CustomerProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Customer> _customerList = [];
  List<Credit> _listCreditsByCustomer = [];
  List<Customer> get customerList => _customerList;
  List<Credit> get listCreditsByCustomer => _listCreditsByCustomer;

  Customer _customerSelected = Customer();
  void getCustomers() async{
    isLoading = true;
    _customerList = await CustomerService().getAllCustomers();
    isLoading = false;
    notifyListeners();
  }
  Customer getCustomerSelected(){
    return _customerSelected;
  }
  void setCustomerSelected(Customer customer){
    _customerSelected = customer;
    notifyListeners();
  }

  void getCreditsByCustomerId(String customerId) async{
  isLoading = true;
    _listCreditsByCustomer = await CustomerService().getCreditsByCustomerId(customerId);
  isLoading = false;
notifyListeners();

  }
  void addCustomer(Customer customer) async{
    await CustomerService().registerCustomer(customer);
    _customerList.add(customer);
    notifyListeners();

  }
  List<Payment> _listPaymentsByCreditId = [];
  Credit _creditSelected = Credit();
  List<Payment> get listPaymentsByCreditId => _listPaymentsByCreditId;
  Credit get creditSelected => _creditSelected;



  void makePaymentCustomer(String customerId, String creditId, int index,String paymentId, String method, double customerPayment)async{
    isLoading = true;
    _listPaymentsByCreditId[index] = await PaymentService().setPayment(paymentId, method, customerPayment);
    _creditSelected = await CreditService().getCreditbyId(creditId);
    _listCreditsByCustomer = await CustomerService().getCreditsByCustomerId(customerId);
    isLoading = false;
    notifyListeners();
  }

  void getPaymentsByCreditId(String creditId) async {
    isLoading = true;
    _listPaymentsByCreditId = await CreditService().getPaymentsByCredit(creditId);
    isLoading = false;
    notifyListeners();
  }
  void getCreditById(String creditId)async{
    isLoading = true;
    _creditSelected = await CreditService().getCreditbyId(creditId);
    isLoading = false;
    notifyListeners();

  }


}