// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      imageLink: json['image_link'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'image_link': instance.imageLink,
      'role': instance.role,
    };
