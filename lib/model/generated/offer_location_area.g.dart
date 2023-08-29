// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_location_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferLocationArea _$OfferLocationAreaFromJson(Map<String, dynamic> json) =>
    OfferLocationArea(
      coords: GeoJsonLocation.fromJson(json['coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfferLocationAreaToJson(OfferLocationArea instance) =>
    <String, dynamic>{
      'coords': instance.coords.toJson(),
    };
