import 'package:flutter/material.dart';

class FilterModel extends ChangeNotifier {
  String message = "";
  String instruction = "";
  String bank = "";
  String amount = "";

  void update(String message, String instruction, String bank, String amount) {
    this.message = message;
    this.instruction = instruction;
    this.bank = bank;
    this.amount = amount;
    
    notifyListeners();
  }
}