import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_tutorial/business_logic/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';


void main() {
  group('CounterCubit', () {
    // CounterCubit underTest;
    //
    // underTest = CounterCubit();
    //
    // // tearDown(() => underTest.close());
    //
    // test('initial state is Countercubit(0)',() {
    //   expect(underTest.state, CounterState(counterValue: 0));
    // });



    blocTest<CounterCubit, CounterState>(
      'initial state',
      build: () => CounterCubit(),
      act: (bloc) {},
      expect: () => <CounterState>[]
    );


    blocTest<CounterCubit, CounterState>(
      'cubit -> emit -> counterstate(1, true) when cubit.increment',
      build: () => CounterCubit(),
      act: (cubit) => cubit.increment(),
      expect: () => <CounterState>[CounterState(counterValue: 1, wasIncremented: true)],
    );

    blocTest<CounterCubit, CounterState>(
      'cubit -> emit -> counterstate(-1, true) when cubit.decrement',
      build: () => CounterCubit(),
      act: (cubit) => cubit.decrement(),
      expect: () => <CounterState>[CounterState(counterValue: -1, wasIncremented: false)],
    );

  });
}

