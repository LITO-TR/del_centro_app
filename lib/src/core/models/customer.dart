import 'dart:convert';

List<Customer> customersFromJson(String str) => List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));
Customer customerFromJson(String str) => Customer.fromJson(jsonDecode(str));

String customersToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String customerToJson(Customer data)=> jsonEncode(data);


class Customer {
  Customer({
     this.id,
     this.name,
     this.lastName,
     this.address,
     this.dni,
     this.civilStatus,
     this.phoneNumber
  });

  String? id;
  String? name;
  String? lastName;
  String? address;
  String? dni;
  String? civilStatus;
  String? phoneNumber;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["_id"],
    name: json["name"],
    lastName: json["lastName"],
    address: json["address"],
    dni: json["DNI"],
    civilStatus: json["civilStatus"],
      phoneNumber: json["phoneNumber"]
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "lastName": lastName,
    "address": address,
    "DNI": dni,
    "civilStatus": civilStatus,
    "phoneNumber": phoneNumber
  };
}
