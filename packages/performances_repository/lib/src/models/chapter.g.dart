// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      title: json['name'] as String,
      place: Place.fromJson(json['place'] as Map<String, dynamic>),
      audioLink: json['audio_link'] as String,
      shortAudioLink: json['short_audio_link'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'name': instance.title,
      'place': instance.place,
      'audio_link': instance.audioLink,
      'short_audio_link': instance.shortAudioLink,
      'images': instance.images,
    };
