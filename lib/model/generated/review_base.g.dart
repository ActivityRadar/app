// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewBase _$ReviewBaseFromJson(Map<String, dynamic> json) => ReviewBase(
      locationId: json['location_id'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      overallRating: (json['overall_rating'] as num).toDouble(),
      details: json['details'] as Object,
    );

Map<String, dynamic> _$ReviewBaseToJson(ReviewBase instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'title': instance.title,
      'text': instance.text,
      'overall_rating': instance.overallRating,
      'details': instance.details,
    };
