// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      id: json['id'] as String,
      status: $enumDecode(_$ParticipantStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$ParticipantStatusEnumMap[instance.status]!,
    };

const _$ParticipantStatusEnumMap = {
  ParticipantStatus.host: 'host',
  ParticipantStatus.requested: 'requested',
  ParticipantStatus.accepted: 'accepted',
  ParticipantStatus.declined: 'declined',
  ParticipantStatus.withdrawn: 'withdrawn',
};
