/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'create_offer_response.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CreateOfferResponse {
  @JsonKey(name: "offer_id")
  final String offerId;

  CreateOfferResponse({required this.offerId});

  factory CreateOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOfferResponseToJson(this);
}
