// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageOut _$MessageOutFromJson(Map<String, dynamic> json) => MessageOut(
      chatId: json['chat_id'] as String,
      message: json['message'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$MessageOutToJson(MessageOut instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'message': instance.message,
    };
