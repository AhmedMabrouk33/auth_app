import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_connection_state.dart';

class NetworkConnectionCubit extends Cubit<NetworkConnectionState> {
  NetworkConnectionCubit() : super(InternetConnectionLoading()) {
    // -~ Listener for Connectivity.
    Connectivity().onConnectivityChanged.listen(
      (internetEvent) {
        if ((internetEvent == ConnectivityResult.mobile) ||
            (internetEvent == ConnectivityResult.wifi)) {
          internetConnected();
        } else {
          internetDisConnected();
        }
      },
    );
  }

  void internetConnected() => emit(InternetConnectedState());
  void internetDisConnected() => emit(NoInternetConnectedState());
}
