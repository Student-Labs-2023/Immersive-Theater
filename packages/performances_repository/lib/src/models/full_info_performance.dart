// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/performances_repository.dart';

part 'full_info_performance.g.dart';

@JsonSerializable()
class FullInfoPerformance {
  @JsonKey(name: 'authors', defaultValue: [])
  final List<Creator> creators;

  @JsonKey(defaultValue: '')
  final String description;

  final Duration duration;

  @JsonKey(defaultValue: [])
  final List<String> images;

  @JsonKey(name: 'audios', defaultValue: [])
  final List<Chapter> chapters;

  FullInfoPerformance(
      {required this.creators,
      required this.description,
      required this.duration,
      required this.images,
      required this.chapters});

  FullInfoPerformance.empty({required this.chapters})
      : creators = [],
        description = '',
        duration = Duration.zero,
        images = [];

  factory FullInfoPerformance.fromJson(Map<String, dynamic> json) =>
      _$FullInfoPerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$FullInfoPerformanceToJson(this);

  FullInfoPerformance copyWith({
    required List<Creator>? creators,
    required String? description,
    required Duration? duration,
    required List<String>? images,
    required List<Chapter>? chapters,
  }) {
    return FullInfoPerformance(
      chapters: chapters ?? this.chapters,
      creators: creators ?? this.creators,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      images: images ?? this.images,
    );
  }
}
