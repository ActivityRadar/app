// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_json_feature_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoJsonFeatureCollection _$GeoJsonFeatureCollectionFromJson(
        Map<String, dynamic> json) =>
    GeoJsonFeatureCollection(
      type: json['type'] as String?,
      geometries: (json['geometries'] as List<dynamic>)
          .map((e) => e as Object)
          .toList(),
    );

Map<String, dynamic> _$GeoJsonFeatureCollectionToJson(
        GeoJsonFeatureCollection instance) =>
    <String, dynamic>{
      'type': instance.type,
      'geometries': instance.geometries,
    };
