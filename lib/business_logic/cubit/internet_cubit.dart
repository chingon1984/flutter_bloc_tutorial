import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/constants/enum.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit(this.connectivity) : super(InternetLoading()) {
    _monitorConnection();
  }

  void _monitorConnection() {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.mobile);
        return;
      }
    
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.wifi);
        return;
      }
    
      if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
        return;
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());
}
