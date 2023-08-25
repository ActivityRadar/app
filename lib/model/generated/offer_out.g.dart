// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferOut _$OfferOutFromJson(Map<String, dynamic> json) => OfferOut(
      activity:
          (json['activity'] as List<dynamic>).map((e) => e as String).toList(),
      time: json['time'] as Map<String, dynamic>,
      description: json['description'] as String,
      visibility: $enumDecode(_$OfferVisibilityEnumMap, json['visibility']),
      visibilityRadius: (json['visibility_radius'] as num).toDouble(),
      location: json['location'] as Map<String, dynamic>?,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String,
      userInfo:
          OfferCreatorInfo.fromJson(json['user_info'] as Map<String, dynamic>),
      blurrInfo:
          LocationBlurrOut.fromJson(json['blurr_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfferOutToJson(OfferOut instance) {
  final val = <String, dynamic>{
    'activity': instance.activity,
    'time': instance.time,
    'description': instance.description,
    'visibility': _$OfferVisibilityEnumMap[instance.visibility]!,
    'visibility_radius': instance.visibilityRadius,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('location', instance.location);
  val['participants'] = instance.participants.map((e) => e.toJson()).toList();
  val['id'] = instance.id;
  val['user_info'] = instance.userInfo.toJson();
  val['blurr_info'] = instance.blurrInfo.toJson();
  return val;
}

const _$OfferVisibilityEnumMap = {
  OfferVisibility.public: 'public',
};
