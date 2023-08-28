/// This file extends functionality for the data classes defined in ./generated/

import 'package:app/provider/activity_type.dart';
import 'package:intl/intl.dart';
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

String getDateDescription(DateTime date) {
  final today = DateTime.now();
  if (date.isAfter(today.add(const Duration(days: 7)))) {
    final formatter = DateFormat("dd.MM.yyyy");
    return formatter.format(date);
  }

  final todayDate = DateTime(today.year, today.month, today.day);
  final dateDate = DateTime(date.year, date.month, date.day);

  var days = todayDate.difference(dateDate).inDays;
  switch (days) {
    case 0:
      return "Heute";
    case 1:
      return "Morgen";
    default:
      return [
        "Montag",
        "Dienstag",
        "Mittwoch",
        "Donnerstag",
        "Freitag",
        "Samstag",
        "Sonntag"
      ][date.weekday - 1];
  }
}

String formatMeetupTime(DateTime time) {
  final DateFormat timeFormatter = DateFormat("hh:mm");
  return "${timeFormatter.format(time)} Uhr";
}

LocationShortApi fromDetailed(LocationDetailedApi info) {
  // assumes, the detailed model extends the short one
  return LocationShortApi.fromJson(info.toJson());
}
