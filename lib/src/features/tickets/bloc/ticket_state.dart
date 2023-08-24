part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  final List<Performance> tickets;
  const TicketState({required this.tickets});
  @override
  List<Object> get props => [tickets];
}

class TicketLoadInProgress extends TicketState {
  const TicketLoadInProgress({required super.tickets});
  @override
  List<Object> get props => [tickets];
}

class TicketLoadFailure extends TicketState {
  const TicketLoadFailure({required super.tickets});
  @override
  List<Object> get props => [tickets];
}

class TicketFullInfoLoadFailure extends TicketState {
  const TicketFullInfoLoadFailure({required super.tickets});
  @override
  List<Object> get props => [tickets];
}

class TicketLoadSuccess extends TicketState {
  const TicketLoadSuccess({required super.tickets});

  @override
  List<Object> get props => [tickets];
}

class TicketFullInfoLoadInProgress extends TicketState {
  const TicketFullInfoLoadInProgress({required super.tickets});

  @override
  List<Object> get props => [tickets];
}
