/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

import 'package:app/model/generated/tag_change_type.dart';
part 'tag_change.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TagChange {
  final TagChangeType mode;
  final Map<String, dynamic> content;

  TagChange({required this.mode, required this.content});

  factory TagChange.fromJson(Map<String, dynamic> json) =>
      _$TagChangeFromJson(json);

  Map<String, dynamic> toJson() => _$TagChangeToJson(this);
}
