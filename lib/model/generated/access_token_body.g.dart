// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenBody _$AccessTokenBodyFromJson(Map<String, dynamic> json) =>
    AccessTokenBody(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
    );

Map<String, dynamic> _$AccessTokenBodyToJson(AccessTokenBody instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
    };
