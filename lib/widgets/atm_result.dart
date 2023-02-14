import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watm/providers/origins_provider.dart';

import 'package:watm/theme/theme_constants.dart';

import '../providers/atm_provider.dart';
import '../screens/atm_details_screen.dart';

class ATMResult extends StatefulWidget {
  final String name;

  ATMResult({required this.name});

  @override
  State<ATMResult> createState() => _ATMResultState();
}

class _ATMResultState extends State<ATMResult> {
  @override
  Widget build(BuildContext context) {
    final ATM = Provider.of<ATMProvider>(context);
    ATM.updateDistance(Provider.of<OriginsProvider>(context).currentLocation);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ATMDetailsScreen.routeName,
          arguments: ATM.id,
        );
      },
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
                    Text(ATM.getDistance()),
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
                        widget.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${ATM.address}',
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
