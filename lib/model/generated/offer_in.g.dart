// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferIn _$OfferInFromJson(Map<String, dynamic> json) => OfferIn(
      activity:
          (json['activity'] as List<dynamic>).map((e) => e as String).toList(),
      time: json['time'] as Map<String, dynamic>,
      description: DescriptionWithTitle.fromJson(
          json['description'] as Map<String, dynamic>),
      visibility: $enumDecode(_$OfferVisibilityEnumMap, json['visibility']),
      visibilityRadius: (json['visibility_radius'] as num).toDouble(),
      location: json['location'] as Map<String, dynamic>,
      participantLimits: (json['participant_limits'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      blurr: LocationBlurrIn.fromJson(json['blurr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfferInToJson(OfferIn instance) => <String, dynamic>{
      'activity': instance.activity,
      'time': instance.time,
      'description': instance.description.toJson(),
      'visibility': _$OfferVisibilityEnumMap[instance.visibility]!,
      'visibility_radius': instance.visibilityRadius,
      'location': instance.location,
      'participant_limits': instance.participantLimits,
      'blurr': instance.blurr.toJson(),
    };

const _$OfferVisibilityEnumMap = {
  OfferVisibility.public: 'public',
};
