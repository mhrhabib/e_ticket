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
        username: loginModel.data!.user!.username!,
        id: loginModel.data?.user?.id ?? 0,
        name: loginModel.data?.user?.name ?? '',
        fromTicketCounterName: loginModel.data!.user!.fromTicketCounterName!,
        fromTicketCounterNameBn: loginModel.data!.user!.fromTicketCounterNameBn!,
        counterShortName: loginModel.data!.user!.counterShortName!,
        token: loginModel.data?.token ?? '',
        mobile: loginModel.data!.user!.mobile!,
        address: loginModel.data!.user!.address ?? '',
        deviceId: loginModel.data!.user!.deviceId!,
        deviceSerialNumber: loginModel.data!.user!.deviceSerialNumber!,
        ticketCounterId: loginModel.data!.user!.ticketCounterId!,
      );

      return Right(userEntity);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> logOut() async {
    try {
      final result = await remoteDataSource.logOut();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
