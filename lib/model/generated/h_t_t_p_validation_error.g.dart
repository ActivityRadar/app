// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'h_t_t_p_validation_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HTTPValidationError _$HTTPValidationErrorFromJson(Map<String, dynamic> json) =>
    HTTPValidationError(
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HTTPValidationErrorToJson(HTTPValidationError instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('detail', instance.detail?.map((e) => e.toJson()).toList());
  return val;
}
