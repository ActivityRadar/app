// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyUserInfo _$VerifyUserInfoFromJson(Map<String, dynamic> json) =>
    VerifyUserInfo(
      id: json['id'] as String,
      verificationCode: json['verification_code'] as String,
    );

Map<String, dynamic> _$VerifyUserInfoToJson(VerifyUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'verification_code': instance.verificationCode,
    };
