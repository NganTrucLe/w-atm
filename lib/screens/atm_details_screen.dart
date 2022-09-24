import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../widgets/general_info.dart';
import '../models/atm.dart';

class ATMDetailsScreen extends StatelessWidget {
  static const routeName = '/ATM-details';
  final ATM ATMInfo;
  ATMDetailsScreen(this.ATMInfo);
  @override
  Widget build(BuildContext context) {
    //final routeArgs = ModalRoute.of(context)?.settings.arguments as ATM;
    //ATM ATMInfo = routeArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text('ATM Details',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey,
      body: Stack(children: [
        Image(image: AssetImage('assets/images/map.png')),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 480,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14), bottom: Radius.zero),
                  smoothness: 0.6,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: GeneralInfo(ATMInfo),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
