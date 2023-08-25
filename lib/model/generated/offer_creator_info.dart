/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'offer_creator_info.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OfferCreatorInfo {
  final String username;
  @JsonKey(name: "display_name")
  final String displayName;
  final String id;

  OfferCreatorInfo(
      {required this.username, required this.displayName, required this.id});

  factory OfferCreatorInfo.fromJson(Map<String, dynamic> json) =>
      _$OfferCreatorInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OfferCreatorInfoToJson(this);
}
