part of 'connectivity_bloc.dart';

abstract class InternetConnectionEvent extends Equatable {
  const InternetConnectionEvent();

  @override
  List<Object> get props => [];
}

class InternetConnectionStatusChanged extends InternetConnectionEvent {
  final InternetConnectionStatus status;

  const InternetConnectionStatusChanged({required this.status});
  @override
  List<Object> get props => [status];
}
