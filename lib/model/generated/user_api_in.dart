/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'user_api_in.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserApiIn {
  final String username;
  @JsonKey(name: "display_name")
  final String displayName;
  final String email;
  final String password;

  UserApiIn(
      {required this.username,
      required this.displayName,
      required this.email,
      required this.password});

  factory UserApiIn.fromJson(Map<String, dynamic> json) =>
      _$UserApiInFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiInToJson(this);
}
