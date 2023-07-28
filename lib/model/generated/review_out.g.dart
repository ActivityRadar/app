// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewOut _$ReviewOutFromJson(Map<String, dynamic> json) => ReviewOut(
      Id: json['_id'] as String,
      locationId: json['location_id'] as String,
      text: json['text'] as String,
      overallRating: (json['overall_rating'] as num).toDouble(),
      details: json['details'] as Object,
      creationDate: json['creation_date'] as String,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$ReviewOutToJson(ReviewOut instance) => <String, dynamic>{
      '_id': instance.Id,
      'location_id': instance.locationId,
      'text': instance.text,
      'overall_rating': instance.overallRating,
      'details': instance.details,
      'creation_date': instance.creationDate,
      'user_id': instance.userId,
    };
