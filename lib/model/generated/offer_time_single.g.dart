// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_time_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferTimeSingle _$OfferTimeSingleFromJson(Map<String, dynamic> json) =>
    OfferTimeSingle(
      type: json['type'] as String?,
      times: (json['times'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$OfferTimeSingleToJson(OfferTimeSingle instance) =>
    <String, dynamic>{
      'type': instance.type,
      'times': instance.times,
    };
