// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_with_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewWithId _$ReviewWithIdFromJson(Map<String, dynamic> json) => ReviewWithId(
      locationId: json['location_id'] as String,
      description: DescriptionWithTitle.fromJson(
          json['description'] as Map<String, dynamic>),
      overallRating: (json['overall_rating'] as num).toDouble(),
      details: json['details'] as Map<String, dynamic>,
      creationDate: DateTime.parse(json['creation_date'] as String),
      userId: json['user_id'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$ReviewWithIdToJson(ReviewWithId instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'description': instance.description.toJson(),
      'overall_rating': instance.overallRating,
      'details': instance.details,
      'creation_date': instance.creationDate.toIso8601String(),
      'user_id': instance.userId,
      'id': instance.id,
    };
