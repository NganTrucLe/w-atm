import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watm/providers/origins_provider.dart';

import '../providers/atm_provider.dart';
import '../screens/atm_details_screen.dart';
import './status_tag.dart';
import '../theme/theme_constants.dart';
import '../dummy_bank.dart';

class ATM_item_card extends StatelessWidget {
  String FindBank(String bank) {
    for (int i = 0; i < DUMMY_BANKS.length; i = i + 1) {
      if (bank == DUMMY_BANKS[i].name) return DUMMY_BANKS[i].avatarLink;
    }
    return DUMMY_BANKS[0].avatarLink;
  }

  @override
  Widget build(BuildContext context) {
    final ATM = Provider.of<ATMProvider>(context);
    ATM.updateDistance(Provider.of<OriginsProvider>(context).currentLocation);
    return Container(
        margin: EdgeInsets.only(right: 16),
        width: 320,
        height: 80,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ATMDetailsScreen.routeName,
                arguments: ATM.id,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppTheme.colors.white,
                    backgroundImage: AssetImage(FindBank(ATM.bank)),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 32,
                  title: Text(
                    ATM.name != "" ? ATM.bank + ' - ' + ATM.name : ATM.bank,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    ATM.address,
                    maxLines: 2,
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Row(
                  textBaseline: TextBaseline.ideographic,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusTag(ATM.status),
                    Text(
                      ATM.getDistance(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            )));
  }
}
