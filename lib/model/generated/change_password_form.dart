/// THIS FILE HAS BEEN GENERATED BY THE SCRIPT openapi-to-dart.py
///
/// IT IS BEST NOT TO MODIFY IT TO AVOID INCOMPATABILITIES WITH THE API SCHEMA.

import 'package:json_annotation/json_annotation.dart';

part 'change_password_form.g.dart';

@JsonSerializable(explicitToJson: true)
class ChangePasswordForm {
  @JsonKey(name: "new_password")
  final String newPassword;
  @JsonKey(name: "old_password")
  final String oldPassword;

  ChangePasswordForm({
    required this.newPassword,
    required this.oldPassword});

  factory ChangePasswordForm.fromJson(Map<String, dynamic> json) => _$ChangePasswordFormFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordFormToJson(this);
}