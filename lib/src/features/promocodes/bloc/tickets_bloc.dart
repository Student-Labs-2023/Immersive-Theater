import 'package:bloc/bloc.dart';
import 'package:shebalin/src/features/promocodes/bloc/tickets_event.dart';
import 'package:shebalin/src/features/performances/view/widgets/performance_card.dart';
import 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final List<PerformanceCard> _tickets = [];
  List<PerformanceCard> get tickets => _tickets;

  TicketsBloc() : super(TicketsState(tickets: [])) {
    on<AddTicket>((event, emit) {
      _tickets.add(event.ticket);
      emit(TicketsState(tickets: _tickets));
    });
  }
}
