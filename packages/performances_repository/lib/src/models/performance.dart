// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/performances_repository.dart';

part 'performance.g.dart';

@JsonSerializable()
class Performance {
  final int id;

  @JsonKey(name: 'name')
  final String title;

  @JsonKey(name: 'image_link')
  final String imageLink;

  @JsonKey(name: 'authors')
  final List<Creator> creators;

  @JsonKey(defaultValue: '')
  final String description;

  final Duration duration;

  @JsonKey(defaultValue: [])
  final List<String> images;

  @JsonKey(name: 'audio', defaultValue: [])
  final List<Chapter> chapters;

  Performance(
      {required this.id,
      required this.title,
      required this.imageLink,
      required this.creators,
      required this.description,
      required this.duration,
      required this.images,
      required this.chapters});

  factory Performance.fromJson(Map<String, dynamic> json) =>
      _$PerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceToJson(this);

  Performance copyWith({
    int? id,
    String? title,
    String? imageLink,
    List<Creator>? creators,
    String? description,
    Duration? duration,
    List<String>? images,
    List<Chapter>? chapters,
  }) {
    return Performance(
      id: id ?? this.id,
      title: title ?? this.title,
      imageLink: imageLink ?? this.imageLink,
      creators: creators ?? this.creators,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      images: images ?? this.images,
      chapters: chapters ?? this.chapters,
    );
  }
}


// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:json_annotation/json_annotation.dart';
// import 'package:performances_repository/performances_repository.dart';

// part 'performance.g.dart';

// @JsonSerializable()
// class Performance {
//   final int id;

//   @JsonKey(name: 'name')
//   final String title;

//   @JsonKey(name: 'image_link')
//   final String imageLink;

//   @JsonKey(name: 'first_place')
//   final Place firstPlace;

//   @JsonKey(name: 'authors')
//   final List<Creator> creators;

//   @JsonKey(defaultValue: '')
//   final String description;

//   final Duration duration;

//   @JsonKey(defaultValue: [])
//   final List<String> images;

//   @JsonKey(name: 'audio', defaultValue: [])
//   final List<Chapter> chapters;

//   Performance({
//     required this.id,
//     required this.title,
//     required this.imageLink,
//     required this.creators,
//     required this.description,
//     required this.duration,
//     required this.images,
//     required this.chapters,
//     required this.firstPlace,
//   });

//   factory Performance.fromJson(Map<String, dynamic> json) =>
//       _$PerformanceFromJson(json);

//   Map<String, dynamic> toJson() => _$PerformanceToJson(this);

//   Performance copyWith({
//     int? id,
//     String? title,
//     String? imageLink,
//     List<Creator>? creators,
//     String? description,
//     Duration? duration,
//     List<String>? images,
//     List<Chapter>? chapters,
//     Place? firstPlace,
//   }) {
//     return Performance(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         imageLink: imageLink ?? this.imageLink,
//         creators: creators ?? this.creators,
//         description: description ?? this.description,
//         duration: duration ?? this.duration,
//         images: images ?? this.images,
//         chapters: chapters ?? this.chapters,
//         firstPlace: firstPlace ?? this.firstPlace);
//   }
// }
