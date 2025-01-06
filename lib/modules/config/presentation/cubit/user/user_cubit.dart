import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/users_model.dart';
import 'package:e_ticket/modules/config/domain/usecases/get_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsersUseCase getUsersUseCase;

  UserCubit({required this.getUsersUseCase}) : super(UserInitial());

  Future<void> loadUsers() async {
    print('loadUsers() is called');
    emit(UserLoading());

    final users = await getUsersUseCase.execute();
    users.fold(
      (failure) => emit(UserFailUre(_mapFailureToMessage(failure))),
      (user) => emit(UserSuccess(user)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error: ${failure.message}';
    }
    return 'Unexpected Error';
  }
}
