// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationNew _$LocationNewFromJson(Map<String, dynamic> json) => LocationNew(
      activityType: json['activity_type'] as String,
      location:
          GeoJsonLocation.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
      tags: json['tags'],
      geometry: json['geometry'],
    );

Map<String, dynamic> _$LocationNewToJson(LocationNew instance) =>
    <String, dynamic>{
      'activity_type': instance.activityType,
      'location': instance.location.toJson(),
      'name': instance.name,
      'tags': instance.tags,
      'geometry': instance.geometry,
    };
