import 'dart:async';

import 'package:bloc_tutorial/constants/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit(this.internetCubit) : super(const CounterState(counterValue: 0)) {
    _monitorInternetCubit();
  }

  void _monitorInternetCubit() {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected && internetState.connectionType == ConnectionType.wifi) {
        increment();
        return;
      }
    
      if(internetState is InternetConnected && internetState.connectionType == ConnectionType.mobile) {
        decrement();
        return;
      }
    });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));
}
