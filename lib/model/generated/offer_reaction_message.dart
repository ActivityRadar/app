/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'offer_reaction_message.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OfferReactionMessage {
  final String sender;
  final DateTime time;
  final String text;
  @JsonKey(name: "offer_id")
  final String offerId;

  OfferReactionMessage(
      {required this.sender,
      required this.time,
      required this.text,
      required this.offerId});

  factory OfferReactionMessage.fromJson(Map<String, dynamic> json) =>
      _$OfferReactionMessageFromJson(json);

  Map<String, dynamic> toJson() => _$OfferReactionMessageToJson(this);
}
