import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/profile/data/models/profile_model.dart';
import 'package:e_ticket/modules/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository profileRepository;
  GetProfileUseCase(this.profileRepository);

  Future<Either<Failure, ProfilesModel>> execute() {
    return profileRepository.getProfileData();
  }
}
