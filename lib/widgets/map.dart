import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> markers;
  final LatLng location;

  Map(this.markers, this.location);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: location, zoom: 14),
      markers: Set<Marker>.of(markers),
      myLocationEnabled: true,
      compassEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
