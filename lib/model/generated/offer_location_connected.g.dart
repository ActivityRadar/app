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
    OfferLocationConnected instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('coords', instance.coords?.toJson());
  val['id'] = instance.id;
  return val;
}
