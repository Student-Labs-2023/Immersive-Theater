// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Performance _$PerformanceFromJson(Map<String, dynamic> json) => Performance(
      title: json['title'] as String,
      number: json['number'] as int,
      description: json['description'] as String,
      duration: json['duration'] as String,
      freeAudioLink: json['freeAudioLink'] as String,
      audioLinks: (json['audioLinks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      audioTitles: (json['audioTitles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      audioCoverImageLink: json['audioCoverImageLink'] as String,
      authorsName: (json['authorsName'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      authorsRole: (json['authorsRole'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      authorsImage: (json['authorsImage'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      coverImageLink: json['coverImageLink'] as String,
      imagesList: (json['imagesList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      cardImageLink: json['cardImageLink'] as String,
      tag: json['tag'] as String,
    );

Map<String, dynamic> _$PerformanceToJson(Performance instance) =>
    <String, dynamic>{
      'title': instance.title,
      'number': instance.number,
      'description': instance.description,
      'duration': instance.duration,
      'freeAudioLink': instance.freeAudioLink,
      'audioLinks': instance.audioLinks,
      'audioTitles': instance.audioTitles,
      'audioCoverImageLink': instance.audioCoverImageLink,
      'authorsName': instance.authorsName,
      'authorsRole': instance.authorsRole,
      'authorsImage': instance.authorsImage,
      'coverImageLink': instance.coverImageLink,
      'imagesList': instance.imagesList,
      'cardImageLink': instance.cardImageLink,
      'tag': instance.tag,
    };
