/// This file extends functionality for the data classes defined in ./generated/

import 'package:latlong2/latlong.dart';

import 'generated.dart';

LatLng toLatLng(GeoJsonLocation location) {
  return LatLng(location.coordinates[1], location.coordinates[0]);
}

GeoJsonLocation toLongLat(LatLng location) {
  return GeoJsonLocation(coordinates: [location.longitude, location.latitude]);
}

String getTitle(LocationDetailedApi info) {
  if (info.name != null) {
    return info.name!;
  } else {
    // TODO: translate
    return info.activityType;
  }
}
