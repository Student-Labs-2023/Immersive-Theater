// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:performances_repository/src/models/full_info_performance.dart';

part 'performance.g.dart';

@JsonSerializable()
class Performance {
  final int id;
  final String tag;
  @JsonKey(name: 'name')
  final String title;

  @JsonKey(name: 'image_link')
  final String imageLink;

  final FullInfoPerformance info;

  Performance(
      {required this.id,
      required this.title,
      required this.imageLink,
      required this.tag,
      required this.info});

  factory Performance.fromJson(Map<String, dynamic> json) =>
      _$PerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceToJson(this);

  Performance copyWith({
    int? id,
    String? title,
    String? imageLink,
    String? tag,
    FullInfoPerformance? info,
  }) {
    return Performance(
      id: id ?? this.id,
      title: title ?? this.title,
      imageLink: imageLink ?? this.imageLink,
      tag: tag ?? this.tag,
      info: info ?? this.info,
    );
  }
}
