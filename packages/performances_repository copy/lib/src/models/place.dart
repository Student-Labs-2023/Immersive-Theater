import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Place {
  @JsonKey(name: 'authors')
  final String title;
  final String address;
  final double longitude;
  final double latitude;

  Place({
    required this.title,
    required this.address,
    required this.longitude,
    required this.latitude,
  });
}
