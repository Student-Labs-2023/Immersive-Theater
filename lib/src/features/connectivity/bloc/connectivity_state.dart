part of 'connectivity_bloc.dart';

class InternetConnectionState extends Equatable {
  const InternetConnectionState._({
    required this.status,
  });

  const InternetConnectionState.connected()
      : this._(status: InternetConnectionStatus.connected);

  const InternetConnectionState.disconnected()
      : this._(status: InternetConnectionStatus.disconnected);

  final InternetConnectionStatus status;
  @override
  List<Object> get props => [status];
}
