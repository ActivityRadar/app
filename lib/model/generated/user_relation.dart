/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

import 'package:app/model/generated/relation_status.dart';
part 'user_relation.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRelation {
  @JsonKey(name: "_id")
  final String? Id;
  final List<String> users;
  @JsonKey(name: "creation_date")
  final String creationDate;
  final RelationStatus status;

  UserRelation({
    this.Id,
    required this.users,
    required this.creationDate,
    required this.status});

  factory UserRelation.fromJson(Map<String, dynamic> json) => _$UserRelationFromJson(json);

  Map<String, dynamic> toJson() => _$UserRelationToJson(this);
}