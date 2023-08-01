// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsSummary _$ReviewsSummaryFromJson(Map<String, dynamic> json) =>
    ReviewsSummary(
      averageRating: (json['average_rating'] as num).toDouble(),
      count: json['count'] as int,
      recent: (json['recent'] as List<dynamic>)
          .map((e) => ReviewWithId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsSummaryToJson(ReviewsSummary instance) =>
    <String, dynamic>{
      'average_rating': instance.averageRating,
      'count': instance.count,
      'recent': instance.recent.map((e) => e.toJson()).toList(),
    };
