import 'package:performances_repository/performances_repository.dart';

class CurrentPerformanceProvider {
  final Performance performance;
  String get title => performance.title;
  CurrentPerformanceProvider({
    required this.performance,
  });
}
