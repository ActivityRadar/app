// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiIn _$UserApiInFromJson(Map<String, dynamic> json) => UserApiIn(
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserApiInToJson(UserApiIn instance) => <String, dynamic>{
      'username': instance.username,
      'display_name': instance.displayName,
      'email': instance.email,
      'password': instance.password,
    };
