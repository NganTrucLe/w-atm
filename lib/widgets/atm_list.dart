import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../models/atm.dart';
import 'atm_item_card.dart';

class ATMlist extends StatefulWidget {
  @override
  State<ATMlist> createState() => _ATMlistState();
}

class _ATMlistState extends State<ATMlist> {
  late ATM _item;
  List<ATM> ATMItem = [];

  Future<dynamic> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    return await json.decode(response);
  }

  @override
  void initState() {
    readJson().then((data) async {
      setState(() {
        for (int i = 0; i < data["All"].length; i++) {
          _item = ATM(
              bank: data["All"][i]["Bank"],
              name: data["All"][i]["Name"] ?? "",
              address: data["All"][i]["Address"],
              phone: data["All"][i]["Phone"] ?? "");
          ATMItem.add(_item);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          height: 200,
          child: ListView.builder(
              itemCount: ATMItem.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return ATM_item_card(ATMInfo: ATMItem[index]);
              }),
        )
      ],
    );
  }
}
