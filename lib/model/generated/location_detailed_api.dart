/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

import 'package:app/model/generated/geo_json_location.dart';
import 'package:app/model/generated/review_base.dart';
import 'package:app/model/generated/photo_info.dart';
part 'location_detailed_api.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationDetailedApi {
  @JsonKey(name: "activity_type")
  final String activityType;
  final GeoJsonLocation location;
  final String? name;
  @JsonKey(name: "trust_score")
  final int trustScore;
  @JsonKey(name: "average_rating")
  final double? averageRating;
  final Object tags;
  @JsonKey(name: "recent_reviews")
  final List<ReviewBase> recentReviews;
  final Object? geometry;
  final List<PhotoInfo>? photos;

  LocationDetailedApi({
    required this.activityType,
    required this.location,
    this.name,
    required this.trustScore,
    this.averageRating,
    required this.tags,
    required this.recentReviews,
    this.geometry,
    this.photos});

  factory LocationDetailedApi.fromJson(Map<String, dynamic> json) => _$LocationDetailedApiFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDetailedApiToJson(this);
}