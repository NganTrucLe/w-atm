import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../widgets/general_info.dart';
import '../models/atm.dart';

class ATMDetailsScreen extends StatelessWidget {
  static const routeName = '/ATM-details';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as ATM;
    ATM ATMInfo = routeArgs;
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
        body: Stack(
          children: [
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.7,
                maxChildSize: 0.7,
                minChildSize: 0.2,
                snapSizes: [0.2, 0.4, 0.7],
                snap: true,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: SmoothRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(14), bottom: Radius.zero),
                          smoothness: 0.6,
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: GeneralInfo(scrollController, ATMInfo)));
                },
              ),
            ),
          ],
        ));
  }
}
