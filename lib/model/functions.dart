/// This file extends functionality for the data classes defined in ./generated/

import 'package:app/provider/activity_type.dart';
import 'package:latlong2/latlong.dart';

import 'generated.dart';

LatLng toLatLng(GeoJsonLocation location) {
  return LatLng(location.coordinates[1], location.coordinates[0]);
}

GeoJsonLocation toLongLat(LatLng location) {
  return GeoJsonLocation(
      type: "Point", coordinates: [location.longitude, location.latitude]);
}

String formatGeoLocation(GeoJsonLocation location) {
  return "${location.coordinates[0]}; ${location.coordinates[1]}";
}

String getTitle(LocationDetailedApi info) {
  if (info.name != null) {
    return info.name!;
  } else {
    // TODO: translate
    return info.activityTypes
        .map((s) => ActivityManager.instance.getDisplayType(s))
        .join(", ");
  }
}

LocationShortApi fromDetailed(LocationDetailedApi info) {
  // assumes, the detailed model extends the short one
  return LocationShortApi.fromJson(info.toJson());
}
