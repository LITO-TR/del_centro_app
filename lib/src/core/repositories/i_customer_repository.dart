import 'package:del_centro_app/src/core/models/customer.dart';

abstract class ICustomerRepository{
  Future<List<Customer>> getAllCustomers();
}