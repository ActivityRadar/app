// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_with_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewWithId _$ReviewWithIdFromJson(Map<String, dynamic> json) => ReviewWithId(
      locationId: json['location_id'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      overallRating: (json['overall_rating'] as num).toDouble(),
      details: json['details'] as Object,
      creationDate: json['creation_date'] as String,
      userId: json['user_id'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$ReviewWithIdToJson(ReviewWithId instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'title': instance.title,
      'text': instance.text,
      'overall_rating': instance.overallRating,
      'details': instance.details,
      'creation_date': instance.creationDate,
      'user_id': instance.userId,
      'id': instance.id,
    };
