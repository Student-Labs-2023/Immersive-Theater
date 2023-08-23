// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Performance _$PerformanceFromJson(Map<String, dynamic> json) => Performance(
      id: json['id'] as int,
      title: json['name'] as String,
      imageLink: json['image_link'] as String,
      tag: json['tag'] as String,
      info: FullInfoPerformance.empty(chapters: [
        Chapter.fromJson(json['first_place'] as Map<String, dynamic>)
      ]),
      price: json['price'] as int,
      duration: Duration(seconds: json['duration'] as int),
      bought: json['access'] as bool,
    );

Map<String, dynamic> _$PerformanceToJson(Performance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'name': instance.title,
      'image_link': instance.imageLink,
      'price': instance.price,
      'duration': instance.duration.inSeconds,
      'info': instance.info,
    };
