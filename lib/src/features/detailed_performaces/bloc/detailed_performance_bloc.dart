import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detailed_performance_event.dart';
part 'detailed_performance_state.dart';

class DetailedPerformanceBloc extends Bloc<DetailedPerformanceEvent, DetailedPerformanceState> {
  DetailedPerformanceBloc() : super(DetailedPerformanceInitial()) {
    on<DetailedPerformanceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
