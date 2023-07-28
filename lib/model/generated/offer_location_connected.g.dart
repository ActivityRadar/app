// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_location_connected.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferLocationConnected _$OfferLocationConnectedFromJson(
        Map<String, dynamic> json) =>
    OfferLocationConnected(
      coords: json['coords'] == null
          ? null
          : GeoJsonLocation.fromJson(json['coords'] as Map<String, dynamic>),
      id: json['id'] as String,
    );

Map<String, dynamic> _$OfferLocationConnectedToJson(
        OfferLocationConnected instance) =>
    <String, dynamic>{
      'coords': instance.coords?.toJson(),
      'id': instance.id,
    };
