import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:performances_repository/src/models/performance.dart';
import 'package:performances_repository/src/performaces_repository.dart';
import 'package:api_client/api_client.dart';

enum _PerformancesEndpoint {
  everything('perfomances'),
  byId('perfomances/'),
  myperfs('my_perfomances');

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
  Future<List<Performance>> fetchPerformances(String userId) async {
    final response =
        await _apiClient.dio.get(_PerformancesEndpoint.everything.endpoint,
            queryParameters: {
              'user_id': userId,
            },
            options: Options(responseType: ResponseType.json));
    final result = ResponseMapper.fromJson(jsonDecode(response.data));
    final List<Performance> performances = [];
    for (final rawPerformance in result.data) {
      performances.add(Performance.fromJson(rawPerformance));
    }
    return performances;
  }

  @override
  Future<List<Performance>> fetchBoughtPerformances(String userId) async {
    final response =
        await _apiClient.dio.get(_PerformancesEndpoint.myperfs.endpoint,
            queryParameters: {
              'user_id': userId,
            },
            options: Options(responseType: ResponseType.json));
    final result = ResponseMapper.fromJson(jsonDecode(response.data));
    final List<Performance> performances = [];
    for (final rawPerformance in result.data) {
      performances.add(Performance.fromJson(rawPerformance));
    }
    return performances;
  }

  @override
  Future<Performance> fetchPerformanceById(int id, String userId) async {
    final response = await _apiClient.dio
        .get(_PerformancesEndpoint.byId.endpoint + id.toString(),
            queryParameters: {
              'user_id': userId,
            },
            options: Options(
              responseType: ResponseType.json,
            ));
    log(response.data.toString());
    final Performance performance =
        Performance.fromJson(jsonDecode(response.data));
    return performance;
  }
}
