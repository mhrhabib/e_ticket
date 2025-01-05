part of 'counter_cubit.dart';

sealed class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

final class CounterInitial extends CounterState {}

final class CounterLoading extends CounterState {}

final class CounterSuccess extends CounterState {
  final List<Counter> counters;

  const CounterSuccess(this.counters);
}

final class CounterFailure extends CounterState {
  final String message;

  const CounterFailure(this.message);
}
