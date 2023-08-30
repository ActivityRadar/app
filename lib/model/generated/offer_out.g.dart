// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferOut _$OfferOutFromJson(Map<String, dynamic> json) => OfferOut(
      activity:
          (json['activity'] as List<dynamic>).map((e) => e as String).toList(),
      time: json['time'] as Map<String, dynamic>,
      description: DescriptionWithTitle.fromJson(
          json['description'] as Map<String, dynamic>),
      visibility: $enumDecode(_$OfferVisibilityEnumMap, json['visibility']),
      visibilityRadius: (json['visibility_radius'] as num).toDouble(),
      location: json['location'] as Map<String, dynamic>?,
      participantLimits: (json['participant_limits'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      creationDate: DateTime.parse(json['creation_date'] as String),
      userInfo:
          OfferCreatorInfo.fromJson(json['user_info'] as Map<String, dynamic>),
      blurrInfo:
          LocationBlurrOut.fromJson(json['blurr_info'] as Map<String, dynamic>),
      status: $enumDecode(_$OfferStatusEnumMap, json['status']),
      id: json['id'] as String,
    );

Map<String, dynamic> _$OfferOutToJson(OfferOut instance) {
  final val = <String, dynamic>{
    'activity': instance.activity,
    'time': instance.time,
    'description': instance.description.toJson(),
    'visibility': _$OfferVisibilityEnumMap[instance.visibility]!,
    'visibility_radius': instance.visibilityRadius,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('location', instance.location);
  val['participant_limits'] = instance.participantLimits;
  val['participants'] = instance.participants.map((e) => e.toJson()).toList();
  val['creation_date'] = instance.creationDate.toIso8601String();
  val['user_info'] = instance.userInfo.toJson();
  val['blurr_info'] = instance.blurrInfo.toJson();
  val['status'] = _$OfferStatusEnumMap[instance.status]!;
  val['id'] = instance.id;
  return val;
}

const _$OfferVisibilityEnumMap = {
  OfferVisibility.public: 'public',
};

const _$OfferStatusEnumMap = {
  OfferStatus.open: 'open',
  OfferStatus.closed: 'closed',
  OfferStatus.timeout: 'timeout',
};
