// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_change.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagChange _$TagChangeFromJson(Map<String, dynamic> json) => TagChange(
      mode: $enumDecode(_$TagChangeTypeEnumMap, json['mode']),
      content: json['content'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$TagChangeToJson(TagChange instance) => <String, dynamic>{
      'mode': _$TagChangeTypeEnumMap[instance.mode]!,
      'content': instance.content,
    };

const _$TagChangeTypeEnumMap = {
  TagChangeType.add: 'add',
  TagChangeType.delete: 'delete',
  TagChangeType.change: 'change',
};
