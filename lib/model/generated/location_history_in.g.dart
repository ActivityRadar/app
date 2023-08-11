// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_history_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationHistoryIn _$LocationHistoryInFromJson(Map<String, dynamic> json) =>
    LocationHistoryIn(
      locationId: json['location_id'] as String,
      before: json['before'] as Map<String, dynamic>?,
      after: json['after'] as Map<String, dynamic>?,
      tags: json['tags'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LocationHistoryInToJson(LocationHistoryIn instance) {
  final val = <String, dynamic>{
    'location_id': instance.locationId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('before', instance.before);
  writeNotNull('after', instance.after);
  writeNotNull('tags', instance.tags);
  return val;
}
