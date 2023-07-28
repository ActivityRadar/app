// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordForm _$ChangePasswordFormFromJson(Map<String, dynamic> json) =>
    ChangePasswordForm(
      newPassword: json['new_password'] as String,
      oldPassword: json['old_password'] as String,
    );

Map<String, dynamic> _$ChangePasswordFormToJson(ChangePasswordForm instance) =>
    <String, dynamic>{
      'new_password': instance.newPassword,
      'old_password': instance.oldPassword,
    };
