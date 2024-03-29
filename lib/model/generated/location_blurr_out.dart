/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

import 'package:app/model/generated/geo_json_location.dart';
part 'location_blurr_out.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocationBlurrOut {
  final double radius;
  final GeoJsonLocation center;

  LocationBlurrOut({required this.radius, required this.center});

  factory LocationBlurrOut.fromJson(Map<String, dynamic> json) =>
      _$LocationBlurrOutFromJson(json);

  Map<String, dynamic> toJson() => _$LocationBlurrOutToJson(this);
}
