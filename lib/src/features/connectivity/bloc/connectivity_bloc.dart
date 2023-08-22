import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  final InternetConnectionStatus internetConnectionStatus;

  late final StreamSubscription<InternetConnectionStatus> internetConnectionSub;
  InternetConnectionBloc(this.internetConnectionStatus)
      : super(
          internetConnectionStatus == InternetConnectionStatus.connected
              ? const InternetConnectionState.connected()
              : const InternetConnectionState.disconnected(),
        ) {
    on<InternetConnectionStatusChanged>(_onInternetConnectionStatusChanged);
    internetConnectionSub =
        InternetConnectionChecker().onStatusChange.listen((status) {
      log(status.name);
      add(
        InternetConnectionStatusChanged(
          status: status,
        ),
      );
    });
  }

  FutureOr<void> _onInternetConnectionStatusChanged(
    InternetConnectionStatusChanged event,
    Emitter<InternetConnectionState> emit,
  ) {
    emit(
      event.status == InternetConnectionStatus.connected
          ? const InternetConnectionState.connected()
          : const InternetConnectionState.disconnected(),
    );
  }

  @override
  Future<void> close() {
    internetConnectionSub.cancel();
    return super.close();
  }
}
