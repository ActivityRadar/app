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
      trustScore: json['trust_score'] as int,
      tags: json['tags'] as Map<String, dynamic>?,
      geometry: json['geometry'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LocationNewToJson(LocationNew instance) {
  final val = <String, dynamic>{
    'activity_type': instance.activityType,
    'location': instance.location.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['trust_score'] = instance.trustScore;
  writeNotNull('tags', instance.tags);
  writeNotNull('geometry', instance.geometry);
  return val;
}
