import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/map.dart';

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

  @override
  void initState() {
    Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        _currentLocation =
            LatLng(currLocation.latitude, currLocation.longitude);
        _addNewMarker('My current location', currLocation);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Map(_markers, _currentLocation!),
    );
  }
}
