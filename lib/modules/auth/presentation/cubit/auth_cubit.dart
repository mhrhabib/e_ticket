import 'package:e_ticket/core/common/helper/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/usecases/login_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({required this.loginUseCase}) : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());

    final result = await loginUseCase.execute(email, password);

    result.fold(
      (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
      (user) {
        emit(AuthSuccess(user));
        storage.write('userId', user.id);
        storage.write('token', user.token);
        storage.write('counterId', user.ticketCounterId);
      },
    );
  }

  Future logOut() async {
    emit(const AuthLoading());
    final result = await loginUseCase.logOut();
    result.fold(
      (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
      (user) => emit(AuthLogOutSuccess(user)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error: ${failure.message}';
    }
    return 'Unexpected Error';
  }
}
