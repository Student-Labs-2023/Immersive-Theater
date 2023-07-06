import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable()
class Location {
  const Location({
    required this.title,
    required this.paidAudioLink,
    required this.longitude,
    required this.tag,
    required this.number,
    required this.description,
    required this.latitude,
    required this.imageLinks,
    required this.freeAudioLink,
  });

  final String title;
  final List<String> paidAudioLink;
  final String longitude;
  final String tag;
  final String number;
  final String description;
  final String latitude;
  final List<String> imageLinks;
  final String freeAudioLink;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
