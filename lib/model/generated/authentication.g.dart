// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      type: $enumDecode(_$AuthTypeEnumMap, json['type']),
      passwordHash: json['password_hash'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'type': _$AuthTypeEnumMap[instance.type]!,
      'password_hash': instance.passwordHash,
      'email': instance.email,
    };

const _$AuthTypeEnumMap = {
  AuthType.password: 'password',
  AuthType.apple: 'apple',
  AuthType.google: 'google',
};
