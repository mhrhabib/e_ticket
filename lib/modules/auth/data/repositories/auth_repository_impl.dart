import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final loginModel = await remoteDataSource.login(email, password);

      // Map LoginModel to UserEntity
      final userEntity = UserEntity(
        id: loginModel.data?.user?.id ?? 0,
        name: loginModel.data?.user?.name ?? '',
        email: loginModel.data?.user?.email ?? '',
        token: loginModel.data?.token ?? '',
      );

      return Right(userEntity);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
