// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_time_flexible.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferTimeFlexible _$OfferTimeFlexibleFromJson(Map<String, dynamic> json) =>
    OfferTimeFlexible(
      type: json['type'] as String?,
    );

Map<String, dynamic> _$OfferTimeFlexibleToJson(OfferTimeFlexible instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  return val;
}
