// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferIn _$OfferInFromJson(Map<String, dynamic> json) => OfferIn(
      location: json['location'] as Map<String, dynamic>,
      activity:
          (json['activity'] as List<dynamic>).map((e) => e as String).toList(),
      time: json['time'] as Map<String, dynamic>,
      description: json['description'] as String,
      visibility: $enumDecode(_$OfferVisibilityEnumMap, json['visibility']),
    );

Map<String, dynamic> _$OfferInToJson(OfferIn instance) => <String, dynamic>{
      'location': instance.location,
      'activity': instance.activity,
      'time': instance.time,
      'description': instance.description,
      'visibility': _$OfferVisibilityEnumMap[instance.visibility]!,
    };

const _$OfferVisibilityEnumMap = {
  OfferVisibility.public: 'public',
};
