// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_blurr_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationBlurrOut _$LocationBlurrOutFromJson(Map<String, dynamic> json) =>
    LocationBlurrOut(
      radius: (json['radius'] as num).toDouble(),
      center: GeoJsonLocation.fromJson(json['center'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationBlurrOutToJson(LocationBlurrOut instance) =>
    <String, dynamic>{
      'radius': instance.radius,
      'center': instance.center.toJson(),
    };
