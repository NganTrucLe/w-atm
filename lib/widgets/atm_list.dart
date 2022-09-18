import 'package:flutter/material.dart';
import '../models/atm.dart';

import '../dummy_data.dart';
import 'atm_item_card.dart';

class ATMlist extends StatelessWidget {
  static const List<ATM> ATMItem = DUMMY_ATMS;
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
            },
          ),
        ),
      ],
    );
  }
}
