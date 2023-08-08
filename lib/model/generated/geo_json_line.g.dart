// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_json_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoJsonLine _$GeoJsonLineFromJson(Map<String, dynamic> json) => GeoJsonLine(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
    );

Map<String, dynamic> _$GeoJsonLineToJson(GeoJsonLine instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
