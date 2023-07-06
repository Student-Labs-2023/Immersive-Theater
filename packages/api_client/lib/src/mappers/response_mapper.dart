import 'package:json_annotation/json_annotation.dart';

part 'response_mapper.g.dart';

@JsonSerializable()
class ResponseMapper {
 
  final List<Map<String, dynamic>> data;

  ResponseMapper({
  
    required this.data,
  });

  factory ResponseMapper.fromJson(Map<String, dynamic> json) =>
      _$ResponseMapperFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMapperToJson(this);
}
