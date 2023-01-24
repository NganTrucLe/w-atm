import 'package:flutter/cupertino.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class OriginsProvider with ChangeNotifier {
  LatLng _currentLocation = LatLng(0.0, 0.0);
  String _currentAddress = "";
  var _isInit = false;
  LatLng get currentLocation {
    return LatLng(_currentLocation.latitude,_currentLocation.longitude);
  }

  String get currentAddress {
    return _currentAddress;
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
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
      _isInit = true;
      notifyListeners();
    }).catchError((e) {
      _isInit = false;
      debugPrint(e);
    });
  }

  Future<Position> _getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<void> updateLocation() async {
    _getUserCurrentLocation().then((position) async {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _getAddressFromLatLng(_currentLocation);
    });
  }
}
