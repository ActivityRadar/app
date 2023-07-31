/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

import 'package:app/model/generated/offer_visibility.dart';
part 'offer_in.g.dart';

@JsonSerializable(explicitToJson: true)
class OfferIn {
  final Object location;
  final List<String> activity;
  final Object time;
  final String description;
  final OfferVisibility visibility;

  OfferIn({
    required this.location,
    required this.activity,
    required this.time,
    required this.description,
    required this.visibility});

  factory OfferIn.fromJson(Map<String, dynamic> json) => _$OfferInFromJson(json);

  Map<String, dynamic> toJson() => _$OfferInToJson(this);
}
