import 'package:dio/dio.dart';
import 'package:locations_repository/src/locations_repository.dart';
import 'package:locations_repository/src/models/models.dart';
import 'package:api_client/api_client.dart';

enum _LocationsEndpoint {
  everything('locations');

  const _LocationsEndpoint(this.endpoint);
  final String endpoint;
}

class LocationsRepositoryIml implements LocationsRepository {
  final ApiClient _apiClient;
  final String apiKey;

  LocationsRepositoryIml({
    required ApiClient apiClient,
    required this.apiKey,
  })  : assert(apiKey.isNotEmpty, 'Api key must not be empty'),
        _apiClient = apiClient;

  @override
  Future<List<Location>> fetchLocations() async {
    final response = await _apiClient.dio.get(
      _LocationsEndpoint.everything.endpoint,
      options: Options(headers: {"Authorization": "Bearer $apiKey"}),
    );

    final result = ResponseMapper.fromJson(response.data);
    final List<Location> locations = [];
    for (final rawLocation in result.data) {
      locations.add(Location.fromJson(rawLocation));
    }

    return locations;
  }
}
