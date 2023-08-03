// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_info_performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullInfoPerformance _$FullInfoPerformanceFromJson(Map<String, dynamic> json) =>
    FullInfoPerformance(
      creators: (json['authors'] as List<dynamic>?)
              ?.map((e) => Creator.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['description'] as String? ?? '',
      duration: Duration(seconds: json['duration'] as int),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      chapters: (json['audios'] as List<dynamic>?)
              ?.map((e) => Chapter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FullInfoPerformanceToJson(
        FullInfoPerformance instance) =>
    <String, dynamic>{
      'authors': instance.creators,
      'description': instance.description,
      'duration': instance.duration.inMicroseconds,
      'images': instance.images,
      'audio': instance.chapters,
    };
