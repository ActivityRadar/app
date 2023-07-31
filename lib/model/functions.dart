/// This file extends functionality for the data classes defined in ./generated/

import 'package:latlong2/latlong.dart';

import 'generated.dart';

LatLng toLatLng(GeoJsonLocation location) {
  return LatLng(location.coordinates[1], location.coordinates[0]);
}
