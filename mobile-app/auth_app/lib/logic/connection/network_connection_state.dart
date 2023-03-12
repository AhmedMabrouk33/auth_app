part of 'network_connection_cubit.dart';

abstract class NetworkConnectionState extends Equatable {
  const NetworkConnectionState();

  @override
  List<Object> get props => [];
}


class InternetConnectionLoading extends NetworkConnectionState {}

class InternetConnectedState extends NetworkConnectionState {}

class NoInternetConnectedState extends NetworkConnectionState {}

