// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiOut _$UserApiOutFromJson(Map<String, dynamic> json) => UserApiOut(
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      avatar: json['avatar'] == null
          ? null
          : PhotoInfo.fromJson(json['avatar'] as Map<String, dynamic>),
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserApiOutToJson(UserApiOut instance) =>
    <String, dynamic>{
      'username': instance.username,
      'display_name': instance.displayName,
      'avatar': instance.avatar?.toJson(),
      'id': instance.id,
    };
