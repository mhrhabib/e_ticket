import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/counter_model.dart';
import 'package:e_ticket/modules/config/domain/usecases/get_counters_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final GetCountersUsecase getCountersUsecase;
  CounterCubit(this.getCountersUsecase) : super(CounterInitial());

  Future<void> loadCounters() async {
    print('loadCounters() is called');
    emit(CounterLoading());
    final counters = await getCountersUsecase.execute();
    counters.fold(
      (failure) => emit(CounterFailure(_mapFailureToMessage(failure))),
      (counters) => emit(CounterSuccess(counters, null)),
    );
  }

  void selectCounter(Counter selectedCounter) {
    if (state is CounterSuccess) {
      final currentState = state as CounterSuccess;
      emit(CounterSuccess(currentState.counters, selectedCounter)); // Update selectedUser
    }
  }

  void resetCounter() {
    emit(CounterInitial());
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error: ${failure.message}';
    }
    return 'Unexpected Error';
  }
}
