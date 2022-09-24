import 'package:flutter/material.dart';
import 'package:watm/models/bank.dart';
import 'package:watm/theme/theme_constants.dart';
import '../models/atm.dart';
import '../dummy_bank.dart';

class BankCard extends StatelessWidget {
  final Bank BankInfo;

  BankCard(this.BankInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        // onTap: () {
        //   routeArgs = BankInfo.name;
        //   Navigator.of(context).pop(routeArgs);
        // },
        leading: CircleAvatar(
          backgroundColor: AppTheme.colors.white,
          backgroundImage: AssetImage(BankInfo.avatarLink),
        ),
        title: Text(
          BankInfo.name,
          style: TextStyle(
            fontFamily: 'SF-Pro-Text',
            fontSize: 17.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
