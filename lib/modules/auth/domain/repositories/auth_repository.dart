import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, Map<String, dynamic>>> logOut();
}
