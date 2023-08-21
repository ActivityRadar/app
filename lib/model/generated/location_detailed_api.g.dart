// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_detailed_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDetailedApi _$LocationDetailedApiFromJson(Map<String, dynamic> json) =>
    LocationDetailedApi(
      activityTypes: (json['activity_types'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      location:
          GeoJsonLocation.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
      trustScore: json['trust_score'] as int,
      tags: json['tags'] as Map<String, dynamic>,
      geometry: json['geometry'] as Map<String, dynamic>?,
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: ReviewsSummary.fromJson(json['reviews'] as Map<String, dynamic>),
      id: json['id'] as String,
    );

Map<String, dynamic> _$LocationDetailedApiToJson(LocationDetailedApi instance) {
  final val = <String, dynamic>{
    'activity_types': instance.activityTypes,
    'location': instance.location.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['trust_score'] = instance.trustScore;
  val['tags'] = instance.tags;
  writeNotNull('geometry', instance.geometry);
  val['photos'] = instance.photos.map((e) => e.toJson()).toList();
  val['reviews'] = instance.reviews.toJson();
  val['id'] = instance.id;
  return val;
}
