// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiIn _$UserApiInFromJson(Map<String, dynamic> json) => UserApiIn(
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      avatar: json['avatar'] == null
          ? null
          : PhotoInfo.fromJson(json['avatar'] as Map<String, dynamic>),
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserApiInToJson(UserApiIn instance) => <String, dynamic>{
      'username': instance.username,
      'display_name': instance.displayName,
      'avatar': instance.avatar?.toJson(),
      'email': instance.email,
      'password': instance.password,
    };
