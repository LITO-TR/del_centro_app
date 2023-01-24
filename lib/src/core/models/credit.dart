
import 'dart:convert';

List<Credit> creditFromJson(String str) => List<Credit>.from(json.decode(str).map((x) => Credit.fromJson(x)));

String customerToJson(List<Credit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Credit creditJson(String str) => Credit.fromJson(jsonDecode(str));
class Credit {
  Credit({
    this.id,
    this.creditType,
    this.creditAmount,
    this.decimalInterest,
    this.numberOfPayments,
    this.paymentsAmount,
    this.interestAmount,
    this.currentDate,
    this.totalAmount,
    this.paymentMethod,
    this.mora,
    this.firstPayDate,
    this.expirationDate,
    this.disbursedAmount,
    this.debtAmount,
    this.creditStatus,
  });

  String? id;
  String? creditType;
  double? creditAmount;
  double? decimalInterest;
  int? numberOfPayments;
  double? paymentsAmount;
  double? interestAmount;
  String? currentDate;
  double? totalAmount;
  String? paymentMethod;
  double? mora;
  String? firstPayDate;
  String? expirationDate;
  double? disbursedAmount;
  double? debtAmount;
  String? creditStatus;
  String? customerId;
  String? employeeId;

  factory Credit.fromJson(Map<String, dynamic> json) => Credit(
        id: json["_id"],
        creditType: json["creditType"],
        creditAmount: json["creditAmount"].toDouble(),
        decimalInterest: json["decimalInterest"].toDouble(),
        numberOfPayments: json["numberOfPayments"],
        paymentsAmount: json["paymentsAmount"].toDouble(),
        interestAmount: json["interestAmount"].toDouble(),
        currentDate: json["currentDate"],
        totalAmount: json["totalAmount"].toDouble(),
        paymentMethod: json["paymentMethod"],
        mora: json["mora"].toDouble(),
        firstPayDate: json["firstPayDate"],
        expirationDate: json["expirationDate"],
        disbursedAmount: json["disbursedAmount"].toDouble(),
        debtAmount: json["debtAmount"].toDouble(),
        creditStatus: json["creditStatus"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "creditType": creditType,
        "creditAmount": creditAmount,
        "decimalInterest": decimalInterest,
        "numberOfPayments": numberOfPayments,
        "paymentsAmount": paymentsAmount,
        "interestAmount": interestAmount,
        "currentDate": currentDate,
        "totalAmount": totalAmount,
        "paymentMethod": paymentMethod,
        "mora": mora,
        "firstPayDate": firstPayDate,
        "expirationDate": expirationDate,
        "disbursedAmount": disbursedAmount,
        "debtAmount": debtAmount,
        "creditStatus": creditStatus,
      };
}
