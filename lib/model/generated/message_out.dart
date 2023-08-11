/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'message_out.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MessageOut {
  @JsonKey(name: "chat_id")
  final String chatId;
  final Map<String, dynamic> message;

  MessageOut({required this.chatId, required this.message});

  factory MessageOut.fromJson(Map<String, dynamic> json) =>
      _$MessageOutFromJson(json);

  Map<String, dynamic> toJson() => _$MessageOutToJson(this);
}
