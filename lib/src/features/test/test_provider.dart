import 'package:del_centro_app/src/core/services/customer_service.dart';
import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:flutter/cupertino.dart';

class TestProvider extends ChangeNotifier{
  bool isLoading = false;
  List<Customer> _customerList = [];
  List<Credit> _creditCustomerList = [];


  List<Customer> get customerList => _customerList;

  List<Credit> get creditCustomerList => _creditCustomerList;

  void getCustomers() async{
    isLoading = true;
    _customerList = await CustomerService().getAllCustomers();
    isLoading = false;
    notifyListeners();
  }

  void getCreditByCustomerId(String customerId) async{
    isLoading = true;
    _creditCustomerList = await CustomerService().getCreditsByCustomer(customerId);
    isLoading = false;

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