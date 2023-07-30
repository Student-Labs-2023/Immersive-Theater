// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Performance _$PerformanceFromJson(Map<String, dynamic> json) => Performance(
      id: json['id'] as int,
      title: json['name'] as String,
      imageLink: json['image_link'] as String,
      creators: (json['authors'] as List<dynamic>?)
              ?.map((e) => Creator.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['description'] as String? ?? '',
      duration: json['duration'] != null
          ? Duration(seconds: json['duration'] as int)
          : Duration.zero,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      chapters: (json['audio'] as List<dynamic>?)
              ?.map((e) => Chapter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PerformanceToJson(Performance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'image_link': instance.imageLink,
      'authors': instance.creators,
      'description': instance.description,
      'duration': instance.duration.inMicroseconds,
      'images': instance.images,
      'audio': instance.chapters,
    };
