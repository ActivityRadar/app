/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'location_history_in.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationHistoryIn {
  @JsonKey(name: "location_id")
  final String locationId;
  final Map<String, dynamic>? before;
  final Map<String, dynamic>? after;
  final Map<String, dynamic>? tags;

  LocationHistoryIn(
      {required this.locationId, this.before, this.after, this.tags});

  factory LocationHistoryIn.fromJson(Map<String, dynamic> json) =>
      _$LocationHistoryInFromJson(json);

  Map<String, dynamic> toJson() => _$LocationHistoryInToJson(this);
}
