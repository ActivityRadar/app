/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'geo_json_location.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoJsonLocation {
  final String? type;
  final List<double> coordinates;

  GeoJsonLocation({
    this.type,
    required this.coordinates});

  factory GeoJsonLocation.fromJson(Map<String, dynamic> json) => _$GeoJsonLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeoJsonLocationToJson(this);
}
