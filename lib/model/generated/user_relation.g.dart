// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRelation _$UserRelationFromJson(Map<String, dynamic> json) => UserRelation(
      Id: json['_id'] as String?,
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      creationDate: DateTime.parse(json['creation_date'] as String),
      status: $enumDecode(_$RelationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$UserRelationToJson(UserRelation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.Id);
  val['users'] = instance.users;
  val['creation_date'] = instance.creationDate.toIso8601String();
  val['status'] = _$RelationStatusEnumMap[instance.status]!;
  return val;
}

const _$RelationStatusEnumMap = {
  RelationStatus.accepted: 'accepted',
  RelationStatus.pending: 'pending',
  RelationStatus.declined: 'declined',
  RelationStatus.chatting: 'chatting',
};
