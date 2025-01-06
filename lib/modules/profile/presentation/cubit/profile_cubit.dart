import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/profile/data/models/profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_porfile_use_case.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  ProfileCubit({required this.getProfileUseCase}) : super(ProfileInitial());

  Future<void> loadProfilesData() async {
    emit(ProfileLoading());
    final response = await getProfileUseCase.execute();
    response.fold(
      (failure) => emit(ProfileFailure(_mapFailureToMessage(failure))),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error: ${failure.message}';
    } else if (failure is ValidationFailure) {
      return 'Validation Error: ${failure.message}';
    } else if (failure is NetworkFailure) {
      return 'Network Error: ${failure.message}';
    }
    return 'Unexpected Error';
  }
}
