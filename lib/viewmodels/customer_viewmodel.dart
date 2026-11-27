import 'package:flutter/foundation.dart';

import '../models/customer.dart';

class CustomerViewModel extends ChangeNotifier {
  final List<Customer> _customers = [];

  List<Customer> get customers => List.unmodifiable(_customers);

  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners();
  }
}
