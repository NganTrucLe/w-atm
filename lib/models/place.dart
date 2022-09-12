class PlaceLocation {
  final double latitude;
  final double longtitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longtitude,
    required this.address,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;

  Place({
    required this.id,
    required this.title,
    required this.location,
  });
}
