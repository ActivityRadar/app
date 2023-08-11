// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detailed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailed _$UserDetailedFromJson(Map<String, dynamic> json) => UserDetailed(
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      trustScore: json['trust_score'] as int,
      avatar: json['avatar'] == null
          ? null
          : PhotoInfo.fromJson(json['avatar'] as Map<String, dynamic>),
      ipAddress: json['ip_address'] as String?,
      creationDate: DateTime.parse(json['creation_date'] as String),
      lastLocation: json['last_location'] == null
          ? null
          : GeoJsonLocation.fromJson(
              json['last_location'] as Map<String, dynamic>),
      authentication: Authentication.fromJson(
          json['authentication'] as Map<String, dynamic>),
      archivedUntil: json['archived_until'] == null
          ? null
          : DateTime.parse(json['archived_until'] as String),
      admin: json['admin'] as bool?,
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserDetailedToJson(UserDetailed instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'display_name': instance.displayName,
    'trust_score': instance.trustScore,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar?.toJson());
  writeNotNull('ip_address', instance.ipAddress);
  val['creation_date'] = instance.creationDate.toIso8601String();
  writeNotNull('last_location', instance.lastLocation?.toJson());
  val['authentication'] = instance.authentication.toJson();
  writeNotNull('archived_until', instance.archivedUntil?.toIso8601String());
  writeNotNull('admin', instance.admin);
  val['id'] = instance.id;
  return val;
}
