import 'package:json_annotation/json_annotation.dart';
part 'creator.g.dart';

@JsonSerializable()
class Creator {
  final int id;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'image_link')
  final String imageLink;
  final String role;

  Creator({
    required this.id,
    required this.fullName,
    required this.imageLink,
    required this.role,
  });

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorToJson(this);
}
