
import 'package:del_centro_app/src/core/models/payment.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  String url = "http://localhost:9000/api/payments";
  //String url = "http://10.0.2.2:9000/api/payments";



  /*Future<List<Payment>> setPayment(String paymentId) async{
    final res = await http.put(Uri.parse('$url/$paymentId'));
    print(res.body);
    return paymentFromJson(res.body);
  }
*/
  Future<List<Payment>> getPaymentsByDate(String day, String month, String year) async{
    // print(day+month+year);
    final res = await http.get(Uri.parse('$url/day/$day/month/$month/year/$year'));
    return paymentFromJson(res.body);

  }

  Future<Payment> setPayment(String paymentId, String method, double customerPayment) async{
    final res = await http.put(Uri.parse('$url/$paymentId/method/$method/customer-payment/$customerPayment'));
    // print(res.body);
    return paymentJson(res.body);
  }



}
