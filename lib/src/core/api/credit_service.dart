import 'dart:convert';

import 'package:del_centro_app/src/core/models/credit.dart';
import 'package:http/http.dart' as http;
class CreditService{

  // final String url = "https://10.0.2.2:5000/api/credit/";

  void createCredit(double creditAmount, double decimalInterest, int numberOfPayments, String paymentMethod, double mora) async{
    final credit = {
      "creditAmount": creditAmount,
    "decimalInterest": decimalInterest,
    "numberOfPayments": numberOfPayments,
    "paymentMethod": paymentMethod,
    "mora": mora
    };
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    final res = await http.post(Uri.parse("http://localhost:9000/api/credit"),
        headers: headers, body: jsonEncode(credit));
    print('exito');
    print(res.body);

  // var fintest = jsonDecode(response.body);
  //return fintest;

}

}