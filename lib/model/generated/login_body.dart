/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LoginBody {
  @JsonKey(name: "grant_type")
  final String? grantType;
  final String username;
  final String password;
  final String? scope;
  @JsonKey(name: "client_id")
  final String? clientId;
  @JsonKey(name: "client_secret")
  final String? clientSecret;

  LoginBody(
      {this.grantType,
      required this.username,
      required this.password,
      this.scope,
      this.clientId,
      this.clientSecret});

  factory LoginBody.fromJson(Map<String, dynamic> json) =>
      _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}
