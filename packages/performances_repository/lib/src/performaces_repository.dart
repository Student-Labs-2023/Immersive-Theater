import 'package:performances_repository/src/models/full_info_performance.dart';
import 'package:performances_repository/src/models/models.dart';

abstract class PerformancesRepository {
  Future<List<Performance>> fetchPerformances(String userId);
  Future<FullInfoPerformance> fetchPerformanceById(int id, String userId);
  Future<List<Performance>> fetchBoughtPerformances(String userId);
}
