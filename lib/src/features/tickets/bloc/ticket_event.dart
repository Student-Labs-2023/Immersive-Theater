part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class TicketStarted extends TicketEvent {
  final String userId;

  const TicketStarted(this.userId);
}

class TicketRefreshed extends TicketEvent {
  final String userId;

  const TicketRefreshed(this.userId);

  @override
  List<Object> get props => [userId];
}

class TicketLoadFullInfo extends TicketEvent {
  final int id;
  final String userId;

  const TicketLoadFullInfo(this.id, this.userId);
  @override
  List<Object> get props => [id, userId];
}
