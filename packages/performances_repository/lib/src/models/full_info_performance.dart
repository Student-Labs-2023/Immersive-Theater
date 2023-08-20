import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/performances_repository.dart';

part 'full_info_performance.g.dart';

@JsonSerializable()
class FullInfoPerformance {
  @JsonKey(name: 'authors', defaultValue: [])
  final List<Creator> creators;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: [])
  final List<String> images;

  @JsonKey(name: 'audios', defaultValue: [])
  final List<Chapter> chapters;

  FullInfoPerformance(
      {required this.creators,
      required this.description,
      required this.images,
      required this.chapters});

  FullInfoPerformance.empty({required this.chapters})
      : creators = [],
        description = '',
        images = [];

  factory FullInfoPerformance.fromJson(Map<String, dynamic> json) =>
      _$FullInfoPerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$FullInfoPerformanceToJson(this);

  FullInfoPerformance copyWith({
    required List<Creator>? creators,
    required String? description,
    required List<String>? images,
    required List<Chapter>? chapters,
  }) {
    return FullInfoPerformance(
      chapters: chapters ?? this.chapters,
      creators: creators ?? this.creators,
      description: description ?? this.description,
      images: images ?? this.images,
    );
  }
}
