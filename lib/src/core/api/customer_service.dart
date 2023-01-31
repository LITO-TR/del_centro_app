
import 'dart:convert';

import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:del_centro_app/src/core/models/customer.dart';
import 'package:http/http.dart' as http;
class CustomerService{

  String url = "http://localhost:9000/api/customers";

  //String url = "http://10.0.2.2:9000/api/customers";


  Future<List<Customer>> getAllCustomers() async{
  final res = await http.get(Uri.parse(url));

    return customersFromJson(res.body);
    //validators
    //styles for cards
    //search customer
  }
  
  Future<List<Credit>> getCreditsByCustomer(String customerId) async{
    final res = await http.get(Uri.parse('$url/$customerId/credits'));
    return creditFromJson(res.body);
  }

  Future<Customer> registerCustomer(Customer customer) async{
  var obj = {
    "name": customer.name.toString(),
    "lastName": customer.lastName.toString(),
    "DNI": customer.dni.toString(),
    "phoneNumber": customer.phoneNumber.toString(),
    "civilStatus": customer.civilStatus.toString()  ,
  };
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  final res = await http.post(Uri.parse(url),headers: headers,body: jsonEncode(obj));

    return customerFromJson(res.body);

  }
}