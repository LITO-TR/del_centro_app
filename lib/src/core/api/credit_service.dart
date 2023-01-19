import 'dart:convert';

import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:http/http.dart' as http;

class CreditService {
  final String url = "http://localhost:9000/api/credit";

  Future<Credit> createCredit(double creditAmount, double decimalInterest,
      int numberOfPayments, String paymentMethod, double mora) async {
    final credit = {
      "creditAmount": creditAmount,
      "decimalInterest": decimalInterest,
      "numberOfPayments": numberOfPayments,
      "paymentMethod": paymentMethod,
      "mora": mora,
      "customerId": '63c87bc4f110c0f21b2d0d59', // change id
      "employeeId": '63c87cb1f110c0f21b2d0d68' // change id
    };
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    final res = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(credit)); // credit a json
    if (res.statusCode == 200) {
      print('exit');
      var obj = Credit.fromJson(jsonDecode(res.body)); //json a credit

      return obj;
    } else if(res.statusCode == 400){
      print('estoy aqui');
      throw Exception('Failed api');
    }else {
      print('estoy aqui11');
      throw Exception('Failed to load');
    }


  }
}
