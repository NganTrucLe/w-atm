import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import './atm_list_screen.dart';
import '../widgets/map.dart';
import '../widgets/atm_list.dart';
import '../widgets/location.dart';
import '../models/atm.dart';
import '../models/filterModel.dart';
import '../widgets/status_tag.dart';

import '../providers/atm_list.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<Marker> _markers = <Marker>[];
  LatLng? _currentLocation;
  String _currentAddress = "";

  void _addNewMarker(String title, double latitude, double longitude) {
    final newMarker = Marker(
        markerId: MarkerId((_markers.length + 1).toString()),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: title));

    setState(() {
      _markers.add(newMarker);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        if (place.name != "") {
          _currentAddress = place.name!;
          if (place.thoroughfare != "") {
            _currentAddress += " " + place.thoroughfare!;
          }
          if (place.locality != "") {
            _currentAddress += " " + place.locality!;
          } else {
            if (place.subAdministrativeArea != "") {
              _currentAddress += " " + place.subAdministrativeArea!;
            }
          }
        }
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<dynamic> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    return await json.decode(response);
  }

  void _fullList(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListScreen(
            list: Provider.of<ATMs>(context).items,
            origins: _currentLocation as LatLng),
      ),
    );
  }

  @override
  void initState() {
    // Create current location marker
    getUserCurrentLocation().then((value) async {
      setState(() {
        _currentLocation = LatLng(value.latitude, value.longitude);
        _getAddressFromLatLng(value);
        _addNewMarker("My current location", value.latitude, value.longitude);
      });
    });
    // Read json file
    readJson().then((data) async {
      setState(() {
        var list = data["District 1"] + data["District 2"] + data["District 3"];
        list.map((item) async {
          List<Location> locations = await locationFromAddress(item['Address']);
          _addNewMarker(item['Bank'] + ' - ' + item['Name'],
              locations[0].latitude, locations[0].longitude);
          Status ATMStatus = item['Status'].toString().toLowerCase() ==
                  Status.maintenance.name
              ? Status.maintenance
              : item['Status'].toString().toLowerCase() == Status.crowded.name
                  ? Status.crowded
                  : Status.working;
          Type ATMType = item['Type'] == Type.Withdraw.name
              ? Type.Withdraw
              : item['Type'] == Type.Deposit.name
                  ? Type.Deposit
                  : Type.Both;
          Provider.of<ATMs>(context).addATM(ATM(
              bank: item["Bank"] ?? "",
              name: item["Name"] ?? "",
              address: item["Address"] ?? "",
              phone: item["Phone"] ?? "",
              type: ATMType,
              cashThroughBank: item["CTB"] == 1 ? true : false,
              status: ATMStatus,
              latitude: locations[0].latitude,
              longitude: locations[0].longitude));
          // RenderedProvider.of<ATMs>(context).addATM(ATM(
          //     bank: item["Bank"] ?? "",
          //     name: item["Name"] ?? "",
          //     address: item["Address"] ?? "",
          //     phone: item["Phone"] ?? "",
          //     type: ATMType,
          //     cashThroughBank: item["CTB"] == 1 ? true : false,
          //     status: ATMStatus,
          //     latitude: locations[0].latitude,
          //     longitude: locations[0].longitude));
        }).toList();
      });
    });
    super.initState();
  }

  // void _applyFilter() {
  //   var filter = context.read<FilterModel>();
  //   FilterATM filterATM = filter.getFilterATM();
  //   // print(filterATM.bank);
  //   // print(Provider.of<ATMs>(context)._items[0].bank);
  //   setState(() {
  //     RenderedProvider.of<ATMs>(context)._items = [];
  //     Provider.of<ATMs>(context)._items.map((item) => {
  //           if (filterATM.bank == "" || item.bank == filterATM.bank)
  //             {RenderedProvider.of<ATMs>(context).addATM(item)}
  //         }).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //_applyFilter();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _currentLocation == null
                ? const Center(child: CircularProgressIndicator())
                : Map(_markers, _currentLocation!),
            userLocation(_currentAddress),
            _currentLocation == null
                ? const Center(child: CircularProgressIndicator())
                : ATMlist(
                    list: Provider.of<ATMs>(context).items,
                    currentLocation: _currentLocation!),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.small(
                    child: Icon(
                      Icons.zoom_out_map_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () => _fullList(context),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
