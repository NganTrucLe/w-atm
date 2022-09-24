import 'package:flutter/material.dart';
import '../theme/colors.dart';
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
                  child: Icon(
                    Icons.location_pin,
                    color: AppColors().primary400,
                  ),
                  backgroundColor: AppColors().primary100,
                ),
                Text(
                  'x km',
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    color: AppColors().primary400,
                  ),
                ),
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
                      fontFamily: 'SF Pro Text',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors().neutral120,
                    )),
                Text('${ATMInfo.address}',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SF Pro Text',
                      color: AppColors().neutral600,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
