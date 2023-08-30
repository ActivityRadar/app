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

String getDateDescription(DateTime startDate) {
  final now = DateTime.now();
  if (startDate.isAfter(now.add(const Duration(days: 7)))) {
    final formatter = DateFormat("dd.MM.yyyy");
    return formatter.format(startDate);
  }

  final today = DateTime(now.year, now.month, now.day);
  final dateDate = DateTime(startDate.year, startDate.month, startDate.day);

  var days = today.difference(dateDate).inDays;
  if (!today.isAfter(dateDate)) {
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
        ][startDate.weekday - 1];
    }
  } else {
    switch (days) {
      case 1:
        return "Gestern";
      default:
        return "Vor $days Tagen";
    }
  }
}

String formatCreationDate(DateTime date) {
  final now = DateTime.now();
  if (now.isBefore(date)) {
    throw Exception("Creation seems to lie in the future! ($date)");
  }

  Duration difference = now.difference(date);
  final formatter = DateFormat('yyyy-MM-dd');
  Duration dayDifference = DateTime.parse(formatter.format(now))
      .difference(DateTime.parse(formatter.format(date)));

  if (dayDifference.inDays == 1) {
    return "Gestern erstellt";
  } else if (dayDifference.inDays > 1) {
    return "Vor ${dayDifference.inDays} Tagen erstellt";
  } else if (difference.inHours > 0) {
    return "Vor ${difference.inHours} Stunden erstellt";
  } else if (difference.inMinutes > 10) {
    return "Vor ${difference.inMinutes} Minuten erstellt";
  } else {
    return "Vor kurzem erstellt";
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
