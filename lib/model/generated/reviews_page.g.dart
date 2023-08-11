// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsPage _$ReviewsPageFromJson(Map<String, dynamic> json) => ReviewsPage(
      nextOffset: json['next_offset'] as int?,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewWithId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsPageToJson(ReviewsPage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('next_offset', instance.nextOffset);
  val['reviews'] = instance.reviews.map((e) => e.toJson()).toList();
  return val;
}
