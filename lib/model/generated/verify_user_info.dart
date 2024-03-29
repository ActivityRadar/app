/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'verify_user_info.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VerifyUserInfo {
  final String id;
  @JsonKey(name: "verification_code")
  final String verificationCode;

  VerifyUserInfo({required this.id, required this.verificationCode});

  factory VerifyUserInfo.fromJson(Map<String, dynamic> json) =>
      _$VerifyUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyUserInfoToJson(this);
}
