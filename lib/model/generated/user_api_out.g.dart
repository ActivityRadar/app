// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiOut _$UserApiOutFromJson(Map<String, dynamic> json) => UserApiOut(
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      id: json['id'] as String,
      avatar: json['avatar'] == null
          ? null
          : PhotoInfo.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserApiOutToJson(UserApiOut instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'display_name': instance.displayName,
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar?.toJson());
  return val;
}
