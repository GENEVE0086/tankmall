import 'package:flutter/material.dart';

class DeliveryProvide with ChangeNotifier {
  bool isBooked = false;

  changebookState() {
    isBooked = true;
  }
}
