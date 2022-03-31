part of 'counter_cubit.dart';

class CounterState {

  const CounterState({required this.counterValue});

  final int counterValue;

  @override
  String toString() {
  return '$counterValue, ';
   }
}