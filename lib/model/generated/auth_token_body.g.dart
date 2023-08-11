// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokenBody _$AuthTokenBodyFromJson(Map<String, dynamic> json) =>
    AuthTokenBody(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
    );

Map<String, dynamic> _$AuthTokenBodyToJson(AuthTokenBody instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
    };
