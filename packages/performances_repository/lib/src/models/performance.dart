import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/src/models/creator.dart';
import 'package:performances_repository/src/models/performance_full_info.dart';

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
  PerformanceFullInfo? fullInfo;

  Performance({
    required this.id,
    required this.title,
    required this.imageLink,
    required this.creators,
  });

  factory Performance.fromJson(Map<String, dynamic> json) =>
      _$PerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceToJson(this);
}
