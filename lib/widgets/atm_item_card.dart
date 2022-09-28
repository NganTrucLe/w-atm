import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../models/atm.dart';
import '../screens/atm_details_screen.dart';
import './status_tag.dart';
import '../theme/theme_constants.dart';
import '../dummy_bank.dart';
import '../models/bank.dart';

class ATM_item_card extends StatefulWidget {
  final ATM ATMInfo;
  final LatLng origins;

  ATM_item_card({required this.ATMInfo, required this.origins});

  @override
  State<ATM_item_card> createState() => _ATM_item_cardState();
}

class _ATM_item_cardState extends State<ATM_item_card> {
  String distance = "";
  String FindBank(String bank){
    for (int i=0;i<DUMMY_BANKS.length;i=i+1){
      if (bank == DUMMY_BANKS[i].name)
        return DUMMY_BANKS[i].avatarLink;
    }
      return DUMMY_BANKS[0].avatarLink;
  }
  Future<void> getDistanceMatrix() async {
    String destination = Uri.encodeComponent(widget.ATMInfo.address);
    try {
      var response = await Dio().get(
          'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination}&origins=${widget.origins.latitude},${widget.origins.longitude}&key=${GOOGLE_API_KEY}');
      var data = jsonDecode(response.toString());
      setState(() {
        data['status'] == 'OK'
            ? distance = data['rows'][0]['elements'][0]['distance']['text']
            : distance = calculateDistance(
                        widget.ATMInfo.latitude,
                        widget.ATMInfo.longitude,
                        widget.origins.latitude,
                        widget.origins.longitude)
                    .toStringAsFixed(1) +
                " km";
      });
    } catch (e) {
      print(e);
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  void selectATM(BuildContext context, ATM ATMInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ATMDetailsScreen(ATMInfo, distance),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getDistanceMatrix();
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
            onTap: () => selectATM(context, widget.ATMInfo),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppTheme.colors.white,
                    backgroundImage: AssetImage(FindBank(widget.ATMInfo.bank)),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 32,
                  title: Text(
                    widget.ATMInfo.name != ""
                        ? widget.ATMInfo.bank + ' - ' + widget.ATMInfo.name
                        : widget.ATMInfo.bank,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    widget.ATMInfo.address,
                    maxLines: 2,
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Row(
                  textBaseline: TextBaseline.ideographic,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusTag(Status.working),
                    Text(
                      distance,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            )));
  }
}
