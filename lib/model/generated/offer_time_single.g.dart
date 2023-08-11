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

Map<String, dynamic> _$OfferTimeSingleToJson(OfferTimeSingle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  val['times'] = instance.times;
  return val;
}
