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
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$GeoJsonFeatureCollectionToJson(
    GeoJsonFeatureCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  val['geometries'] = instance.geometries;
  return val;
}
