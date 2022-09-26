import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import './table.dart';
import '../models/atm.dart';
import './status_tag.dart';

class GeneralInfo extends StatelessWidget {
  final ATM ATMInfo;

  GeneralInfo(this.ATMInfo);

  static Future<void> _launchGoogleMap(ATM ATMInfo) async {
    String query = Uri.encodeComponent(ATMInfo.address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    String appleMapUrl = "http://maps.apple.com/?q=$query";
    if (Platform.isAndroid) {
      try {
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        }
      } catch (error) {
        throw 'Cannot launch Google map';
      }
    }
    if (Platform.isIOS) {
      try {
        if (await canLaunch(appleMapUrl)) {
          await launch(appleMapUrl);
        }
      } catch (error) {
        throw 'Cannot launch Apple map.';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listItem = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              ATMInfo.name != ""
                  ? '${ATMInfo.bank} - ${ATMInfo.name}'
                  : '${ATMInfo.bank}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          Text(ATMInfo.address),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.call_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          SizedBox(width: 20),
          Text(ATMInfo.phone != "" ? ATMInfo.phone : '+84 28 6265 3500'),
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
          onPressed: () => {_launchGoogleMap(ATMInfo)},
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
