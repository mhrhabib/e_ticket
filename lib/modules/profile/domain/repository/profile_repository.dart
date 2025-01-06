import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/profile/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfilesModel>> getProfileData();
}
