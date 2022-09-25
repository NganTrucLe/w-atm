import 'package:flutter/material.dart';
import 'package:watm/theme/theme_constants.dart';

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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      ),
                      backgroundColor: AppTheme.colors.primary500,
                    ),
                    Text('x km'),
                  ],
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${ATMInfo.address}',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppTheme.colors.neutral500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppTheme.colors.neutral800)
        ],
      ),
    );
  }
}
