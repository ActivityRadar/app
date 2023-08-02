// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_detailed_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDetailedApi _$LocationDetailedApiFromJson(Map<String, dynamic> json) =>
    LocationDetailedApi(
      activityType: json['activity_type'] as String,
      location:
          GeoJsonLocation.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
      trustScore: json['trust_score'] as int,
      tags: json['tags'] as Object,
      geometry: json['geometry'] as Map<String, dynamic>?,
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: ReviewsSummary.fromJson(json['reviews'] as Map<String, dynamic>),
      id: json['id'] as String,
    );

Map<String, dynamic> _$LocationDetailedApiToJson(
        LocationDetailedApi instance) =>
    <String, dynamic>{
      'activity_type': instance.activityType,
      'location': instance.location.toJson(),
      'name': instance.name,
      'trust_score': instance.trustScore,
      'tags': instance.tags,
      'geometry': instance.geometry,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'reviews': instance.reviews.toJson(),
      'id': instance.id,
    };
