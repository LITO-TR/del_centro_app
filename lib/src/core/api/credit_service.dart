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
      "mora": mora
    };
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    final res = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(credit)); // credit a json

    if (res.statusCode == 200) {
      var obj = Credit.fromJson(jsonDecode(res.body)); //json a credit

      return obj;
    } else
      throw Exception('Failed to load post');
  }
}
