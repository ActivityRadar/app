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
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      tags: json['tags'] as Object,
      recentReviews: (json['recent_reviews'] as List<dynamic>)
          .map((e) => ReviewBase.fromJson(e as Map<String, dynamic>))
          .toList(),
      geometry: json['geometry'],
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String,
    );

Map<String, dynamic> _$LocationDetailedApiToJson(
        LocationDetailedApi instance) =>
    <String, dynamic>{
      'activity_type': instance.activityType,
      'location': instance.location.toJson(),
      'name': instance.name,
      'trust_score': instance.trustScore,
      'average_rating': instance.averageRating,
      'tags': instance.tags,
      'recent_reviews': instance.recentReviews.map((e) => e.toJson()).toList(),
      'geometry': instance.geometry,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };
