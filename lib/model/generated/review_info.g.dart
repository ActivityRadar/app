// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewInfo _$ReviewInfoFromJson(Map<String, dynamic> json) => ReviewInfo(
      locationId: json['location_id'] as String,
      text: json['text'] as String,
      overallRating: (json['overall_rating'] as num).toDouble(),
      details: json['details'] as Object,
    );

Map<String, dynamic> _$ReviewInfoToJson(ReviewInfo instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'text': instance.text,
      'overall_rating': instance.overallRating,
      'details': instance.details,
    };
