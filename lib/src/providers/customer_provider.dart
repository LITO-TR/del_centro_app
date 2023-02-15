import 'package:flutter/material.dart';

import '../core/models/credit.dart';
import '../core/models/customer.dart';
import '../core/services/customer_service.dart';

class CustomerProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Customer> _customerList = [];
  List<Credit> _creditCustomerList = [];
  List<Customer> get customerList => _customerList;
  List<Credit> get creditCustomerList => _creditCustomerList;
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

  void getCreditByCustomerId(String customerId) async{
    if(_customerList.isEmpty){
      _creditCustomerList = [];
    }else{
      _creditCustomerList = await CustomerService().getCreditsByCustomer(customerId);
    }
  }
  void addCustomer(Customer customer) async{
    await CustomerService().registerCustomer(customer);
    _customerList.add(customer);
    notifyListeners();

  }
  void deleteCustomer(String customerId)async {
    await CustomerService().deteletCustomer(customerId);
    notifyListeners();
  }
}