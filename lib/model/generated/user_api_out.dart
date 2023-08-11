/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

import 'package:app/model/generated/photo_info.dart';
part 'user_api_out.g.dart';

@JsonSerializable(explicitToJson: true)
class UserApiOut {
  final String username;
  @JsonKey(name: "display_name")
  final String displayName;
  final String id;
  final PhotoInfo? avatar;

  UserApiOut(
      {required this.username,
      required this.displayName,
      required this.id,
      this.avatar});

  factory UserApiOut.fromJson(Map<String, dynamic> json) =>
      _$UserApiOutFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiOutToJson(this);
}
