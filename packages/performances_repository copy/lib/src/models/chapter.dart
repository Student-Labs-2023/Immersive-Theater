import 'package:json_annotation/json_annotation.dart';
import 'package:performances_repository/src/models/place.dart';

@JsonSerializable()
class Chapter {
  final String title;
  final Place place;
  final String audioLink;
  final String shortAudioLink;
  final List<String> images;

  Chapter({
    required this.title,
    required this.place,
    required this.audioLink,
    required this.shortAudioLink,
    required this.images,
  });
}
