// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_full_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceFullInfo _$PerformanceFullInfoFromJson(Map<String, dynamic> json) =>
    PerformanceFullInfo(
      description: json['description'] as String,
      duration: Duration(microseconds: json['duration'] as int),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      chapters: (json['audio'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PerformanceFullInfoToJson(
        PerformanceFullInfo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'duration': instance.duration.inMicroseconds,
      'images': instance.images,
      'audio': instance.chapters,
    };
