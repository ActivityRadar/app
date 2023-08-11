// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_chats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollChatsResponse _$PollChatsResponseFromJson(Map<String, dynamic> json) =>
    PollChatsResponse(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageOut.fromJson(e as Map<String, dynamic>))
          .toList(),
      pollTime: DateTime.parse(json['poll_time'] as String),
    );

Map<String, dynamic> _$PollChatsResponseToJson(PollChatsResponse instance) =>
    <String, dynamic>{
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'poll_time': instance.pollTime.toIso8601String(),
    };
