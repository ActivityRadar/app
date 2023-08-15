// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_json_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoJsonLocation _$GeoJsonLocationFromJson(Map<String, dynamic> json) =>
    GeoJsonLocation(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$GeoJsonLocationToJson(GeoJsonLocation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  val['coordinates'] = instance.coordinates;
  return val;
}
