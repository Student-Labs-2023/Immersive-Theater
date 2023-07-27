// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Performance _$PerformanceFromJson(Map<String, dynamic> json) => Performance(
      id: json['strapi'] as String,
      title: json['name'] as String,
      imageLink: json['image_link'] as String,
      creators: (json['authors'] as List<dynamic>)
          .map((e) => Creator.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..fullInfo = PerformanceFullInfo.fromJson(json);

Map<String, dynamic> _$PerformanceToJson(Performance instance) =>
    <String, dynamic>{
      'strapi': instance.id,
      'name': instance.title,
      'image_link': instance.imageLink,
      'authors': instance.creators,
      'fullInfo': instance.fullInfo,
    };
