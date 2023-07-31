// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsPage _$ReviewsPageFromJson(Map<String, dynamic> json) => ReviewsPage(
      nextOffset: json['next_offset'] as int?,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewOut.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsPageToJson(ReviewsPage instance) =>
    <String, dynamic>{
      'next_offset': instance.nextOffset,
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
    };
