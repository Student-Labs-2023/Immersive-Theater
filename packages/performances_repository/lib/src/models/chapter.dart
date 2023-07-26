import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/src/models/place.dart';
part 'chapter.g.dart';

@JsonSerializable()
class Chapter {
  @JsonKey(name: 'name')
  final String title;
  final Place place;
  @JsonKey(name: 'audio_link')
  final String audioLink;
  @JsonKey(name: 'short_audio_link')
  final String shortAudioLink;
  final List<String> images;

  Chapter({
    required this.title,
    required this.place,
    required this.audioLink,
    required this.shortAudioLink,
    required this.images,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}
