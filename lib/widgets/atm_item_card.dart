import 'package:flutter/material.dart';

import '../models/atm.dart';
import '../screens/atmDetails_screen.dart';

class ATM_item_card extends StatelessWidget {
  final ATM ATMInfo;

  ATM_item_card({required this.ATMInfo});

  @override
  void selectATM(BuildContext context) {
    Navigator.of(context).pushNamed(
      ATMDetailsScreen.routeName,
      arguments: ATMInfo as ATM,
    ).then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
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
            onTap: () => selectATM(context), child: Text(ATMInfo.bank)));
  }
}
