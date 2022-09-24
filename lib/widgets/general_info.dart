import 'package:flutter/material.dart';

import './table.dart';
import '../models/atm.dart';
import './status_tag.dart';

class GeneralInfo extends StatelessWidget {
  final ATM ATMInfo;

  GeneralInfo(this.ATMInfo);

  @override
  Widget build(BuildContext context) {
    final List<Widget> listItem = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${ATMInfo.bank} - ${ATMInfo.name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          StatusTag(),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //textBaseline: TextBaseline.alphabetic,
        children: [
          Icon(Icons.location_on_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          SizedBox(width: 20),
          Text('232 Pasteur, Ward 10, District 1'),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.call_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          SizedBox(width: 20),
          Text('+84 28 6265 3500'),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.access_time_filled_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Not too crowded'),
              Text('Estimated time: 6 mins'),
            ],
          ),
        ],
      ),
      CustomTable(),
      Container(
        margin: EdgeInsets.only(top: 10),
        child: ElevatedButton(
          onPressed: () =>{},
          child: Text(
            'Direct',
          ),
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
        ),
      ),
    ];
    return ListView.builder(
      itemCount: listItem.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          child: listItem[index],
        );
      },
    );
  }
}
