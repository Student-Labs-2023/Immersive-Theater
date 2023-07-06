import 'package:json_annotation/json_annotation.dart';

part 'performance.g.dart';

@JsonSerializable()
class Performance {
  const Performance(
      {required this.title,
      required this.number,
      required this.description,
      required this.duration,
      required this.freeAudioLink,
      required this.audioLinks,
      required this.audioTitles,
      required this.audioCoverImageLink,
      required this.authorsName,
      required this.authorsRole,
      required this.authorsImage,
      required this.coverImageLink,
      required this.imagesList,
      required this.cardImageLink,
      required this.tag});

  final String title;
  final int number;
  final String description;
  final String duration;
  final String freeAudioLink;
  final List<String> audioLinks;
  final List<String> audioTitles;
  final String audioCoverImageLink;
  final List<String> authorsName;
  final List<String> authorsRole;
  final List<String> authorsImage;
  final String coverImageLink;
  final List<String> imagesList;
  final String cardImageLink;
  final String tag;

  factory Performance.fromJson(Map<String, dynamic> json) => _$PerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceToJson(this);

}