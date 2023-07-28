// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoInfo _$PhotoInfoFromJson(Map<String, dynamic> json) => PhotoInfo(
      userId: json['user_id'] as String,
      url: json['url'] as String,
      creationDate: json['creation_date'] as String,
    );

Map<String, dynamic> _$PhotoInfoToJson(PhotoInfo instance) => <String, dynamic>{
      'user_id': instance.userId,
      'url': instance.url,
      'creation_date': instance.creationDate,
    };
