import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:performances_repository/src/models/performance.dart';
import 'package:performances_repository/src/performaces_repository.dart';
import 'package:api_client/api_client.dart';

enum _PerformancesEndpoint {
  everything('perfomances'),
  byId('perfomances/');

  const _PerformancesEndpoint(this.endpoint);
  final String endpoint;
}

class PerformancesRepositoryImpl implements PerformancesRepository {
  final ApiClient _apiClient;
  final String apiKey;

  PerformancesRepositoryImpl({
    required ApiClient apiClient,
    required this.apiKey,
  })  : assert(apiKey.isNotEmpty, 'Api key must not be empty'),
        _apiClient = apiClient;

  @override
  Future<List<Performance>> fetchPerformances() async {
    final response = await _apiClient.dio.get(
        _PerformancesEndpoint.everything.endpoint,
        options: Options(responseType: ResponseType.json));
    final result = ResponseMapper.fromJson(jsonDecode(response.data));
    final List<Performance> performances = [];
    for (final rawPerformance in result.data) {
      performances.add(Performance.fromJson(rawPerformance));
    }

    return performances;
  }

  @override
  Future<Performance> fetchPerformanceById(int id) async {
    final response = await _apiClient.dio.get(
        _PerformancesEndpoint.byId.endpoint + id.toString(),
        options: Options(responseType: ResponseType.json));
    final Performance performance =
        Performance.fromJson(jsonDecode(response.data));
    return performance;
  }
}
