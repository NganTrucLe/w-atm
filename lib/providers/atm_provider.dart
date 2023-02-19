import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/location_helper.dart';
import '../widgets/status_tag.dart';

enum Type {
  Withdraw,
  Deposit,
  Both,
}

class ATMProvider with ChangeNotifier {
  final String id;
  final String bank;
  final String name;
  // final String avatarLink;
  final String address;
  final String phone;
  final Type type;
  final Status status;
  final bool cashThroughBank;
  final double latitude;
  final double longitude;
  double distance;
  ATMProvider({
    required this.id,
    required this.bank,
    required this.name,
    required this.address,
    this.phone = "",
    required this.type,
    required this.status,
    this.cashThroughBank = false,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.distance = 0.0,
  });
  Future<void> _getDistanceMatrix(LatLng position) async {
    String destination = Uri.encodeComponent(address);
    try {
      var response = await Dio().get(
          'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination}&origins=${position.latitude},${position.longitude}&key=${GOOGLE_API_KEY}');
      var data = jsonDecode(response.toString());
      data['status'] == 'OK'
          ? distance = data['rows'][0]['elements'][0]['distance']['text']
          : 0;
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> updateDistance(LatLng position) async {
    distance = _coordinateDistance(
        position.latitude, position.longitude, latitude, longitude);
    _getDistanceMatrix(position).then((_) {});
  }

  String getDistance() {
    if (distance < 0) return "${(distance * 100).ceil().toStringAsFixed(0)}m";
    return "${distance.toStringAsFixed(1)}km";
  }
}
