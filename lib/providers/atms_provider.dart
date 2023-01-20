import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../widgets/location.dart';
import '../widgets/status_tag.dart';
import 'package:http/http.dart' as http;
import '../models/atm.dart';

class ATMsProvider with ChangeNotifier {
  
  Future<void> fetchAndSetATMs() async {
    final url = Uri.https('https://w-atm-6617a-default-rtdb.asia-southeast1.firebasedatabase.app','/atms.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      if (extractedData == null){
        return;
      }
      final List<ATM> loadedATMs = [];
      extractedData.forEach((ATMID, ATMData) {
          // ignore: non_constant_identifier_names
          Status ATMStatus = ATMData['Status'].toString().toLowerCase() ==
                  Status.maintenance.name
              ? Status.maintenance
              : ATMData['Status'].toString().toLowerCase() == Status.crowded.name
                  ? Status.crowded
                  : Status.working;
          // ignore: non_constant_identifier_names
          Type ATMType = ATMData['Type'] == Type.Withdraw.name
              ? Type.Withdraw
              : ATMData['Type'] == Type.Deposit.name
                  ? Type.Deposit
                  : Type.Both;
        loadedATMs.add(ATM(
          address: ATMData['address'],        
          name: ATMData['name'],
          bank: ATMData['bank'],
          type: ATMType,
          cashThroughBank: ATMData['CTB'],
          status: ATMStatus,
          latitude: 0.0,
          longitude: 0.0,
        ));
      });
    }
    catch (error) {
      rethrow;
    }
  }
}