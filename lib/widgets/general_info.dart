import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import '../providers/atm_provider.dart';
import '../providers/atms_provider.dart';
import './table.dart';
import './status_tag.dart';

class GeneralInfo extends StatelessWidget {
  final String ATMId;

  GeneralInfo(this.ATMId);

  static Future<void> _launchGoogleMap(ATMProvider loadedATM) async {
    String query = Uri.encodeComponent(loadedATM.address);
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
    final loadedATM = Provider.of<ATMs>(context).findByID(ATMId);
    final List<Widget> listItem = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [StatusTag(loadedATM.status), Text(loadedATM.getDistance())],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              loadedATM.name != ""
                  ? '${loadedATM.bank} - ${loadedATM.name}'
                  : loadedATM.bank,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //textBaseline: TextBaseline.alphabetic,
        children: [
          Icon(Icons.location_on_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              loadedATM.address,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.call_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          const SizedBox(width: 20),
          Text(loadedATM.phone != "" ? loadedATM.phone : '+84 28 6265 3500'),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.access_time_filled_rounded,
              color: Theme.of(context).primaryColor, size: 24),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text('Not too crowded'),
              const Text('Estimated time: 6 mins'),
            ],
          ),
        ],
      ),
      CustomTable(ATMInfo: loadedATM,),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
          onPressed: () => {_launchGoogleMap(loadedATM)},
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: const Text(
            'Direct',
          ),
        ),
      ),
    ];
    return ListView(
      children: WidgetBuilder(listItem),
    );
  }

  List<Widget> WidgetBuilder(List<Widget> listItem) {
    List<Widget> array = [];
    for (int i = 0; i < listItem.length; i = i + 1) {
      array.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: listItem[i],
      ));
    }
    return array;
  }
}
