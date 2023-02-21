import 'package:flutter/material.dart';

import '../widgets/status_tag.dart';
import '../providers/atm_provider.dart';

class FilterATM {
  String bank = "";
  Type type = Type.Both;
  bool newNotes = false;
  int cash = 0;

  void printVal() {
    print(this.bank);
    print(this.type);
    print(this.newNotes);
    print(this.cash);
  }
}

class ATM {
  final String bank;
  final String name;
  // final String avatarLink;
  final String address;
  final String phone;
  final Type type;
  final Status status;
  final int minimumLimit;
  final bool cashThroughBank;
  final double latitude;
  final double longitude;
  final bool newNotes;

  const ATM(
      {required this.bank,
      required this.name,
      required this.address,
      this.phone = "",
      required this.type,
      required this.cashThroughBank,
      required this.status,
      // required this.density,
      required this.latitude,
      required this.longitude,
      this.minimumLimit = 1000000000,
      this.newNotes = true});
}
