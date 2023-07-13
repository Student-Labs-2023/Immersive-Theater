import 'package:equatable/equatable.dart';

import '../../performances/view/widgets/performance_card.dart';

abstract class TicketsEvent extends Equatable{
}

class AddTicket extends TicketsEvent{
  final PerformanceCard ticket;
  AddTicket(this.ticket);
  
  @override

  List<Object?> get props => [ticket];

}