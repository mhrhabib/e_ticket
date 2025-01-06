import 'package:e_ticket/app/di.dart';
import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:e_ticket/modules/config/presentation/cubit/counter/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> initializeApp() async {
    emit(const SplashLoading());
    print(storage.read('token'));

    try {
      // Simulate API call or initialization logic
      CounterCubit(sl()).loadCounters();
      await Future.delayed(const Duration(seconds: 3));

      // After successful loading
      emit(const SplashSuccess());
    } catch (e) {
      emit(SplashFailure('Failed to initialize app: $e'));
    }
  }
}
