// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_reaction_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferReactionMessage _$OfferReactionMessageFromJson(
        Map<String, dynamic> json) =>
    OfferReactionMessage(
      sender: json['sender'] as String,
      time: json['time'] as String,
      text: json['text'] as String,
      offerId: json['offer_id'] as String,
    );

Map<String, dynamic> _$OfferReactionMessageToJson(
        OfferReactionMessage instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'time': instance.time,
      'text': instance.text,
      'offer_id': instance.offerId,
    };
