// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plain_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlainMessage _$PlainMessageFromJson(Map<String, dynamic> json) => PlainMessage(
      sender: json['sender'] as String,
      time: DateTime.parse(json['time'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$PlainMessageToJson(PlainMessage instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'time': instance.time.toIso8601String(),
      'text': instance.text,
    };
