import 'package:flutter/material.dart';

import '../models/atm.dart';

class ATMResult extends StatelessWidget {
  final ATM ATMInfo;
  final String name;
  
  ATMResult(this.ATMInfo, this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}


