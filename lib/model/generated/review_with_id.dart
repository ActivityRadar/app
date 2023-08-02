/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'review_with_id.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewWithId {
  @JsonKey(name: "location_id")
  final String locationId;
  final String title;
  final String text;
  @JsonKey(name: "overall_rating")
  final double overallRating;
  final Object details;
  @JsonKey(name: "creation_date")
  final DateTime creationDate;
  @JsonKey(name: "user_id")
  final String userId;
  final String id;

  ReviewWithId({
    required this.locationId,
    required this.title,
    required this.text,
    required this.overallRating,
    required this.details,
    required this.creationDate,
    required this.userId,
    required this.id});

  factory ReviewWithId.fromJson(Map<String, dynamic> json) => _$ReviewWithIdFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewWithIdToJson(this);
}
