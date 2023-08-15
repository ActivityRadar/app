// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_short_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationShortApi _$LocationShortApiFromJson(Map<String, dynamic> json) =>
    LocationShortApi(
      activityType: json['activity_type'] as String,
      location:
          GeoJsonLocation.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
      trustScore: json['trust_score'] as int,
      id: json['id'] as String,
    );

Map<String, dynamic> _$LocationShortApiToJson(LocationShortApi instance) {
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
  val['id'] = instance.id;
  return val;
}
