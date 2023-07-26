import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/src/models/author.dart';
import 'package:performances_repository/src/models/chapter.dart';

// part 'performance.g.dart';

@JsonSerializable()
class Performance {
  final String id;

  @JsonKey(name: 'name')
  final String title;

  @JsonKey(name: 'image_link')
  final String imageLink;

  final List<Creator> authors;
  final String? description;
  final Duration? duration;
  final List<String>? images;
  @JsonKey(name: 'authors')
  final List<Chapter>? chapters;

  Performance({
    required this.id,
    required this.title,
    required this.imageLink,
    required this.authors,
    required this.description,
    required this.duration,
    required this.images,
    required this.chapters,
  });

  // factory Performance.fromJson(Map<String, dynamic> json) => _$PerformanceFromJson(json);

  // Map<String, dynamic> toJson() => {_$PerformanceToJson(this)};
}
