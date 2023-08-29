// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewBase _$ReviewBaseFromJson(Map<String, dynamic> json) => ReviewBase(
      locationId: json['location_id'] as String,
      description: DescriptionWithTitle.fromJson(
          json['description'] as Map<String, dynamic>),
      overallRating: (json['overall_rating'] as num).toDouble(),
      details: json['details'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ReviewBaseToJson(ReviewBase instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'description': instance.description.toJson(),
      'overall_rating': instance.overallRating,
      'details': instance.details,
    };
