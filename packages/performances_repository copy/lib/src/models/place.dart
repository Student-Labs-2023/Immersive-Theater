import 'package:json_annotation/json_annotation.dart';
part 'place.g.dart';

@JsonSerializable()
class Place {
  @JsonKey(name: 'name')
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

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
