// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_history_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationHistoryIn _$LocationHistoryInFromJson(Map<String, dynamic> json) =>
    LocationHistoryIn(
      locationId: json['location_id'] as String,
      before: json['before'],
      after: json['after'],
      tags: json['tags'],
    );

Map<String, dynamic> _$LocationHistoryInToJson(LocationHistoryIn instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'before': instance.before,
      'after': instance.after,
      'tags': instance.tags,
    };
