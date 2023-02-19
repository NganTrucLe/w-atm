import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:watm/providers/atms_provider.dart';

class Map extends StatefulWidget {
  final LatLng location;

  // Map(this.markers, this.location);
  Map(this.location);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<ATMs>(context).addNewMarker("My current location",
        widget.location.latitude, widget.location.longitude);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final markers = Provider.of<ATMs>(context).markers;
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: widget.location, zoom: 14),
      markers: Set<Marker>.of(markers),
      myLocationEnabled: true,
      compassEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
