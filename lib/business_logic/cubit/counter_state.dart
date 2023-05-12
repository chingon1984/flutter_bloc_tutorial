part of 'counter_cubit.dart';

class CounterState extends Equatable{
  final int counterValue;
  final bool? wasIncremented;


  const CounterState({
    required this.counterValue,
    this.wasIncremented,
  });

  @override
  List<Object> get props => [counterValue, wasIncremented ?? false];

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'] as int,
      wasIncremented: map['wasIncremented'] as bool,
    );
  }

  @override
  String toString() {
    return 'CounterState{counterValue: $counterValue, wasIncremented: $wasIncremented}';
  }
}
