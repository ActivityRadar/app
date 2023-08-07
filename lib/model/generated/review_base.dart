/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'review_base.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewBase {
  @JsonKey(name: "location_id")
  final String locationId;
  final String title;
  final String text;
  @JsonKey(name: "overall_rating")
  final double overallRating;
  final Map<String, dynamic> details;

  ReviewBase({
    required this.locationId,
    required this.title,
    required this.text,
    required this.overallRating,
    required this.details});

  factory ReviewBase.fromJson(Map<String, dynamic> json) => _$ReviewBaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewBaseToJson(this);
}
