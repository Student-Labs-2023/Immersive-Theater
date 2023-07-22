import '../../performances/view/widgets/performance_card.dart';

class TicketsState {
  List<PerformanceCard> tickets;

  TicketsState({required this.tickets});

  List<Object>? get properties => [tickets];
}
