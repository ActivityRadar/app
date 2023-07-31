// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRelation _$UserRelationFromJson(Map<String, dynamic> json) => UserRelation(
      Id: json['_id'] as String?,
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      creationDate: json['creation_date'] as String,
      status: $enumDecode(_$RelationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$UserRelationToJson(UserRelation instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'users': instance.users,
      'creation_date': instance.creationDate,
      'status': _$RelationStatusEnumMap[instance.status]!,
    };

const _$RelationStatusEnumMap = {
  RelationStatus.accepted: 'accepted',
  RelationStatus.pending: 'pending',
  RelationStatus.declined: 'declined',
  RelationStatus.chatting: 'chatting',
};
