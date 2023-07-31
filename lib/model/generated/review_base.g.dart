// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewBase _$ReviewBaseFromJson(Map<String, dynamic> json) => ReviewBase(
      locationId: json['location_id'] as String,
      text: json['text'] as String,
      overallRating: (json['overall_rating'] as num).toDouble(),
      details: json['details'] as Object,
      creationDate: json['creation_date'] as String,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$ReviewBaseToJson(ReviewBase instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'text': instance.text,
      'overall_rating': instance.overallRating,
      'details': instance.details,
      'creation_date': instance.creationDate,
      'user_id': instance.userId,
    };
