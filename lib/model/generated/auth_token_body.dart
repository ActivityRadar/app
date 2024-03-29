/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'auth_token_body.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AuthTokenBody {
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "token_type")
  final String tokenType;

  AuthTokenBody({required this.accessToken, required this.tokenType});

  factory AuthTokenBody.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenBodyToJson(this);
}
