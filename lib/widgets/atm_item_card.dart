import 'package:flutter/material.dart';

import '../models/atm.dart';
import '../screens/atm_details_screen.dart';

class ATM_item_card extends StatelessWidget {
  final ATM ATMInfo;

  ATM_item_card({required this.ATMInfo});

  @override
  void selectATM(BuildContext context, ATM ATMInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ATMDetailsScreen(ATMInfo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 16),
        width: 320,
        height: 120,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
            onTap: () => selectATM(context, ATMInfo), child: Text(ATMInfo.bank)));
  }
}
