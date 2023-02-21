import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watm/models/atm.dart';

import 'dart:convert';

import '../widgets/status_tag.dart';
import 'package:http/http.dart' as http;
import './atm_provider.dart';

class ATMs with ChangeNotifier {
  List<ATMProvider> _items = [];
  List<Marker> _markers = <Marker>[];

  bool isFiltered = false;
  FilterATM _filter = FilterATM();

  List<ATMProvider> get items {
    return [..._items];
  }

  FilterATM get filter {
    return this.filter;
  }

  ATMProvider findByID(String id) {
    return _items.firstWhere((element) => (element.id == id));
  }

  Future<void> fetchAndSetATMs() async {
    final url = Uri.https(
        'https://w-atm-6617a-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/atms.json');
    try {
      final response = await http.get(url);
      final extractedData =
          json.decode(response.body.toString()) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<ATMProvider> loadedATMs = [];
      _items = loadedATMs;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final extractedData = await json.decode(response) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    final List<ATMProvider> loadedATMs = [];
    var cnt = 0;
    extractedData["ATMs"].forEach((ATMData) {
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
      loadedATMs.add(ATMProvider(
          id: cnt.toString(),
          address: ATMData['Address'] ?? "",
          name: ATMData['Name'] ?? "",
          bank: ATMData['Bank'] ?? "",
          type: ATMType,
          cashThroughBank: ATMData['CTB'],
          status: ATMStatus,
          latitude: ATMData['Latitude'],
          longitude: ATMData['Longitude']));
      cnt++;
    });
    _items = loadedATMs;
    notifyListeners();
  }

  Future<void> addNewMarker(
      String title, double latitude, double longitude) async {
    final newMarker = Marker(
        markerId: MarkerId((_markers.length + 1).toString()),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: title));
    _markers.add(newMarker);
  }

  Future<void> _addMarkers() async {
    listATMs.forEach((element) {
      addNewMarker(
          element.name != ""
              ? element.bank + " - " + element.name
              : element.bank,
          element.latitude,
          element.longitude);
    });
  }

  List<Marker> get markers {
    Marker cur = _markers[0];
    _markers.clear();
    _markers.add(cur);
    _addMarkers();
    return [..._markers];
  }

  List<ATMProvider> itemsWithFilter() {
    return _items
        .where((element) =>
            element.bank.contains(_filter.bank) &&
            element.minimumLimit >= _filter.cash &&
            !(!element.newNotes &&
                _filter.newNotes &&
                (element.type == Type.Both || element.type == _filter.type)))
        .toList();
  }

  List<ATMProvider> get listATMs {
    return isFiltered ? itemsWithFilter() : items;
  }

  void updateFilter(FilterATM filterATM) {
    this._filter = filterATM;
    this.isFiltered = true;
    notifyListeners();
    print("Filter Updated");
  }

  void removeFilter() => this.isFiltered = false;
}
