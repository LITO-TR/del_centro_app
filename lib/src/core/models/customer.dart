import 'dart:convert';

List<Customer> customerFromJson(String str) => List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));
Customer customerJson(String str) => Customer.fromJson(jsonDecode(str));

String customerToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  Customer({
    required this.id,
    required this.name,
    required this.lastName,
    required this.createdAt,
    required this.updateAt,
    required this.address,
    required this.dni,
    required this.civilStatus,
    required this.phoneNumber
  });

  String id;
  String name;
  String lastName;
  DateTime createdAt;
  DateTime updateAt;
  String address;
  String dni;
  String civilStatus;
  String phoneNumber;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["_id"],
    name: json["name"],
    lastName: json["lastName"],
    createdAt: DateTime.parse(json["createdAt"]),
    updateAt: DateTime.parse(json["updateAt"]),
    address: json["address"],
    dni: json["DNI"],
    civilStatus: json["civilStatus"],
      phoneNumber: json["phoneNumber"]
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "lastName": lastName,
    "createdAt": createdAt.toIso8601String(),
    "updateAt": updateAt.toIso8601String(),
    "address": address,
    "DNI": dni,
    "civilStatus": civilStatus,
    "phoneNumber": phoneNumber
  };
}
