import 'package:flutter/material.dart';

import '../models/atm.dart';
import '../screens/atm_details_screen.dart';

class ATMResult extends StatelessWidget {
  final ATM ATMInfo;
  final String name;
  
  ATMResult(this.ATMInfo, this.name);

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
    return InkWell(
      onTap: () => selectATM(context, ATMInfo),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                CircleAvatar(
                  child: Icon(Icons.location_pin),
                ),
                Text('x km'),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                Text('${ATMInfo.address}', style: TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


