import 'package:performances_repository/src/models/models.dart';

abstract class PerformancesRepository {
  Future<List<Performance>> fetchPerformances();
  Future<Performance> fetchPerformanceById(String id);
}
