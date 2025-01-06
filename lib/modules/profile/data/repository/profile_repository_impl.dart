import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/profile/data/datasource/profile_remote_data_source.dart';
import 'package:e_ticket/modules/profile/data/models/profile_model.dart';
import 'package:e_ticket/modules/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, ProfilesModel>> getProfileData() async {
    try {
      final profile = await profileRemoteDataSource.fetchProfilesData();

      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
