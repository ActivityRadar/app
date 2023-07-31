/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'geo_json_feature_collection.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoJsonFeatureCollection {
  final String? type;
  final List<Object> geometries;

  GeoJsonFeatureCollection({
    this.type,
    required this.geometries});

  factory GeoJsonFeatureCollection.fromJson(Map<String, dynamic> json) => _$GeoJsonFeatureCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$GeoJsonFeatureCollectionToJson(this);
}
