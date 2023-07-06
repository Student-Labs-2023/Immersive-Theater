// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      title: json['title'] as String,
      paidAudioLink: (json['paidAudioLink'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      longitude: json['longitude'] as String,
      tag: json['tag'] as String,
      number: json['number'] as String,
      description: json['description'] as String,
      latitude: json['latitude'] as String,
      imageLinks: (json['imageLinks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      freeAudioLink: json['freeAudioLink'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'title': instance.title,
      'paidAudioLink': instance.paidAudioLink,
      'longitude': instance.longitude,
      'tag': instance.tag,
      'number': instance.number,
      'description': instance.description,
      'latitude': instance.latitude,
      'imageLinks': instance.imageLinks,
      'freeAudioLink': instance.freeAudioLink,
    };
