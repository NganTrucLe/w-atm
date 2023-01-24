import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../providers/atms_provider.dart';
import '../widgets/general_info.dart';
import '../models/atm.dart';

class ATMDetailsScreen extends StatelessWidget {
  static const routeName = '/ATM-details';
  final ATM ATMInfo;
  final String distance;
  ATMDetailsScreen(this.ATMInfo, this.distance);
  @override
  Widget build(BuildContext context) {
    //final routeArgs = ModalRoute.of(context)?.settings.arguments as ATM;
    //ATM ATMInfo = routeArgs;
    final dummyATMs = Provider.of<ATMs>(context);
    print(dummyATMs.items);
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
              constraints: BoxConstraints(minHeight: 450, maxHeight: 550),
              padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14), bottom: Radius.zero),
                  smoothness: 0.6,
                ),
              ),
              child: GeneralInfo(ATMInfo,distance),
            ),
          ],
        ),
      ]),
    );
  }
}
