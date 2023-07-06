// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_mapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMapper _$ResponseMapperFromJson(Map<String, dynamic> json) =>
    ResponseMapper(
      data: (json['data'] as List<dynamic>)
          .map((e) => e["attributes"] as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ResponseMapperToJson(ResponseMapper instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
