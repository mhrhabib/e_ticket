import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import '../../domain/repository/user_repositoy.dart';
import '../datasources/config_remote_data_source.dart';
import '../models/users_model.dart';

class UserRepositoryImpl implements UserRepository {
  final ConfigRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final response = await remoteDataSource.fetchUsers();

      return Right(response.data!);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
