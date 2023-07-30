import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/performances_repository.dart';
part 'performance_full_info.g.dart';

@JsonSerializable()
class PerformanceFullInfo {
  final String description;
  final Duration duration;
  final List<String> images;
  @JsonKey(name: 'audio')
  // TODO: replace key
  final List<Chapter> chapters;

  PerformanceFullInfo({
    required this.description,
    required this.duration,
    required this.images,
    required this.chapters,
  });

  factory PerformanceFullInfo.fromJson(Map<String, dynamic> json) =>
      _$PerformanceFullInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceFullInfoToJson(this);
}
