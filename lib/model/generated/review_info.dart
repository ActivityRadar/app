/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'review_info.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewInfo {
  @JsonKey(name: "location_id")
  final String locationId;
  final String text;
  @JsonKey(name: "overall_rating")
  final double overallRating;
  final Object details;

  ReviewInfo({
    required this.locationId,
    required this.text,
    required this.overallRating,
    required this.details});

  factory ReviewInfo.fromJson(Map<String, dynamic> json) => _$ReviewInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewInfoToJson(this);
}
