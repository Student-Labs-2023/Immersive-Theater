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
  final int price;
  final Duration duration;

  final FullInfoPerformance info;

  Performance(
      {required this.id,
      required this.title,
      required this.imageLink,
      required this.tag,
      required this.info,
      required this.price,
      required this.duration});

  factory Performance.fromJson(Map<String, dynamic> json) =>
      _$PerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceToJson(this);

  Performance copyWith({
    int? id,
    String? title,
    String? imageLink,
    String? tag,
    int? price,
    Duration? duration,
    FullInfoPerformance? info,
  }) {
    return Performance(
      id: id ?? this.id,
      title: title ?? this.title,
      imageLink: imageLink ?? this.imageLink,
      tag: tag ?? this.tag,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      info: info ?? this.info,
    );
  }
}
