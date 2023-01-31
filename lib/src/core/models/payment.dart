import 'dart:convert';

List<Payment> paymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Payment paymentJson(String str) => Payment.fromJson(jsonDecode(str));

class Payment {
  Payment({
    this.id,
    this.paymentOrder,
    this.date,
    this.payment,
    this.status,
    this.paymentDate,
    this.moraDays,
    this.paymentMethod,
    this.customerPayment,
    this.creditId,
  });

  String? id;
  int? paymentOrder;
  String? date;
  double? payment;
  String? status;
  String? paymentDate;
  int? moraDays;
  String? paymentMethod;
  double? customerPayment;
  String? creditId;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["_id"],
        paymentOrder: json["paymentOrder"],
        date: json["date"],
        payment: json["payment"].toDouble(),
        status: json["status"],
        paymentDate: json["paymentDate"],
        moraDays: json["moraDays"],
        paymentMethod: json["paymentMethod"],
        customerPayment: json["customerPayment"].toDouble(),
        creditId: json["creditId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "paymentOrder": paymentOrder,
        "date": date,
        "payment": payment,
        "status": status,
        "paymentDate": paymentDate,
        "moraDays": moraDays,
        "paymentMethod": paymentMethod,
        "customerPayment": customerPayment,
        "creditId": creditId,
      };
}
