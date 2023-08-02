/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

import 'package:app/model/generated/auth_type.dart';
part 'authentication.g.dart';

@JsonSerializable(explicitToJson: true)
class Authentication {
  final AuthType type;
  @JsonKey(name: "password_hash")
  final String? passwordHash;
  final String? email;

  Authentication({
    required this.type,
    this.passwordHash,
    this.email});

  factory Authentication.fromJson(Map<String, dynamic> json) => _$AuthenticationFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}
