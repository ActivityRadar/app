/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'create_location_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateLocationResponse {
  final String id;

  CreateLocationResponse({required this.id});

  factory CreateLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLocationResponseToJson(this);
}
