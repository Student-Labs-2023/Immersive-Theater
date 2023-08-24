import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:performances_repository/performances_repository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final PerformancesRepository _performancesRepository;
  TicketBloc({required PerformancesRepository performancesRepository})
      : _performancesRepository = performancesRepository,
        super(const TicketLoadInProgress(tickets: [])) {
    on<TicketStarted>(_onTicketStarted);
    on<TicketRefreshed>(_onTicketRefreshed);
    on<TicketLoadFullInfo>(_onTicketLoadFullInfo);
  }

  Future<void> _onTicketStarted(
    TicketStarted event,
    Emitter<TicketState> emit,
  ) async {
    try {
      final tickets =
          await _performancesRepository.fetchBoughtPerformances(event.userId);
      if (tickets.isEmpty) {
        return emit(const TicketLoadFailure(tickets: []));
      }
      emit(TicketLoadSuccess(tickets: tickets));
    } catch (_) {
      emit(const TicketLoadFailure(tickets: []));
      rethrow;
    }
  }

  Future<void> _onTicketRefreshed(
    TicketRefreshed event,
    Emitter<TicketState> emit,
  ) async {
    try {
      final tickets =
          await _performancesRepository.fetchBoughtPerformances(event.userId);
      if (tickets.isEmpty) {
        return emit(const TicketLoadFailure(tickets: []));
      }
      emit(TicketLoadSuccess(tickets: tickets));
    } catch (_) {
      emit(const TicketLoadFailure(tickets: []));
      rethrow;
    }
  }

  Future<void> _onTicketLoadFullInfo(
    TicketLoadFullInfo event,
    Emitter<TicketState> emit,
  ) async {
    emit(TicketLoadInProgress(tickets: state.tickets));
    try {
      final Performance performance =
          await _performancesRepository.fetchPerformanceById(
        event.id,
        event.userId,
      );

      emit(
        TicketLoadSuccess(
          tickets: state.tickets
              .map(
                (perf) => (perf.id != event.id)
                    ? perf
                    : perf.copyWith(info: performance.info),
              )
              .toList(),
        ),
      );
    } catch (_) {
      emit(TicketLoadFailure(tickets: state.tickets));
    }
  }
}
