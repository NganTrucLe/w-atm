import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../models/atm.dart';
import '../screens/atm_details_screen.dart';

class ATM_item_card extends StatefulWidget {
  final ATM ATMInfo;
  final LatLng origins;

  ATM_item_card({required this.ATMInfo, required this.origins});

  @override
  State<ATM_item_card> createState() => _ATM_item_cardState();
}

class _ATM_item_cardState extends State<ATM_item_card> {
  String distance = "";

  Future<void> getDistanceMatrix() async {
    String destination = Uri.encodeComponent(widget.ATMInfo.address);
    try {
      var response = await Dio().get(
          'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination}&origins=${widget.origins.latitude},${widget.origins.longitude}&key=${GOOGLE_API_KEY}');
      List<Location> locations =
          await locationFromAddress(widget.ATMInfo.address);
      var data = jsonDecode(response.toString());
      setState(() {
        data['status'] == 'OK'
            ? distance = data['rows'][0]['elements'][0]['distance']['text']
            : distance = calculateDistance(
                        locations[0].latitude,
                        locations[0].longitude,
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
        builder: (context) => ATMDetailsScreen(ATMInfo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getDistanceMatrix();
    return Container(
        margin: EdgeInsets.only(right: 16),
        width: 320,
        height: 120,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
            onTap: () => selectATM(context, widget.ATMInfo),
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.ATMInfo.name != ""
                      ? widget.ATMInfo.bank + ' - ' + widget.ATMInfo.name
                      : widget.ATMInfo.bank),
                  subtitle: Text(widget.ATMInfo.address),
                ),
                Text(
                  distance,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )));
  }
}
