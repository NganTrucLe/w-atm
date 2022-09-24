import 'package:flutter/material.dart';

import '../models/atm.dart';
import 'atm_item_card.dart';

class ATMlist extends StatefulWidget {
  final List<ATM> list;

  ATMlist({required this.list});

  @override
  State<ATMlist> createState() => _ATMlistState();
}

class _ATMlistState extends State<ATMlist> {
  late ATM _item;
  List<ATM> ATMItem = [];

  @override
  void initState() {
    ATMItem = widget.list;
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
