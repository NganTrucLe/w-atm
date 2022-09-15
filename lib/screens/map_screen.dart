import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import './atmDetails_screen.dart';
import '../widgets/map.dart';
import '../widgets/ATMlist.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<Marker> _markers = <Marker>[];
  LatLng? _currentLocation;

  void _addNewMarker(String title, Position location) {
    final newMarker = Marker(
        markerId: MarkerId((_markers.length + 1).toString()),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: InfoWindow(title: title));

    setState(() {
      _markers.add(newMarker);
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

  @override
  void initState() {
    // Geolocator.getCurrentPosition().then((currLocation) {
    //   setState(() {
    //     _currentLocation =
    //         LatLng(currLocation.latitude, currLocation.longitude);
    //     _addNewMarker('My current location', currLocation);
    //   });
    // });
    getUserCurrentLocation().then((value) async {
      setState(() {
        _currentLocation = LatLng(value.latitude, value.longitude);
        _addNewMarker('My current location', value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Map'),),
      body: //ATMlist(),
          Stack(
        children: [
          _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : Map(_markers, _currentLocation!),
          ATMlist(),
        ],
      ),
    );
  }
}
