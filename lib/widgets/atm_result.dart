import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:watm/providers/origins_provider.dart';

import 'package:watm/theme/theme_constants.dart';
import '../helpers/location_helper.dart';

import '../providers/atm_provider.dart';
import '../screens/atm_details_screen.dart';

class ATMResult extends StatefulWidget {
  final ATMProvider ATMInfo;
  final String name;

  ATMResult({required this.ATMInfo, required this.name});

  @override
  State<ATMResult> createState() => _ATMResultState();
}

class _ATMResultState extends State<ATMResult> {
  String distance = "";

  void selectATM(BuildContext context, ATMProvider ATMInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ATMDetailsScreen(ATMInfo, distance),
      ),
    );
  }

  Future<void> getDistanceMatrix(LatLng origins) async {
    String destination = Uri.encodeComponent(widget.ATMInfo.address);
    try {
      var response = await Dio().get(
          'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination}&origins=${origins.latitude},${origins.longitude}&key=${GOOGLE_API_KEY}');
      List<Location> locations =
          await locationFromAddress(widget.ATMInfo.address);
      var data = jsonDecode(response.toString());
      setState(() {
        data['status'] == 'OK'
            ? distance = data['rows'][0]['elements'][0]['distance']['text']
            : distance = calculateDistance(
                        locations[0].latitude,
                        locations[0].longitude,
                        origins.latitude,
                        origins.longitude)
                    .toStringAsFixed(1);
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
  Widget build(BuildContext context) {
    final origins = Provider.of<OriginsProvider>(context);
    getDistanceMatrix(origins.currentLocation);
    return InkWell(
      onTap: () => selectATM(context, widget.ATMInfo),
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
                    Text('${distance} km'),
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
                        '${widget.ATMInfo.address}',
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
