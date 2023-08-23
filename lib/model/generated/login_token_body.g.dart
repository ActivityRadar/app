// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_token_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginTokenBody _$LoginTokenBodyFromJson(Map<String, dynamic> json) =>
    LoginTokenBody(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$LoginTokenBodyToJson(LoginTokenBody instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'refresh_token': instance.refreshToken,
    };
