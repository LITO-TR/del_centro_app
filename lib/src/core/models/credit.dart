// To parse this JSON data, do
//
//     final credit = creditFromJson(jsonString);

import 'dart:convert';

List<Credit?>? creditFromJson(String str) => json.decode(str) == null ? [] : List<Credit?>.from(json.decode(str)!.map((x) => Credit.fromJson(x)));

String creditToJson(List<Credit?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

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
  int? paymentsAmount;
  int? interestAmount;
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
    creditAmount: json["creditAmount"],
    decimalInterest: json["decimalInterest"].toDouble(),
    numberOfPayments: json["numberOfPayments"],
    paymentsAmount: json["paymentsAmount"],
    interestAmount: json["interestAmount"],
    currentDate: json["currentDate"],
    totalAmount: json["totalAmount"],
    paymentMethod: json["paymentMethod"],
    mora: json["mora"].toDouble(),
    firstPayDate: json["firstPayDate"],
    expirationDate: json["expirationDate"],
    disbursedAmount: json["disbursedAmount"],
    debtAmount: json["debtAmount"],
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