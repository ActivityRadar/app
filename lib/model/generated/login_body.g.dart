// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) => LoginBody(
      grantType: json['grant_type'] as String?,
      username: json['username'] as String,
      password: json['password'] as String,
      scope: json['scope'] as String?,
      clientId: json['client_id'] as String?,
      clientSecret: json['client_secret'] as String?,
    );

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('grant_type', instance.grantType);
  val['username'] = instance.username;
  val['password'] = instance.password;
  writeNotNull('scope', instance.scope);
  writeNotNull('client_id', instance.clientId);
  writeNotNull('client_secret', instance.clientSecret);
  return val;
}
