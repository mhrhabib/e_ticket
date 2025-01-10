import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute(String email, String password) {
    return repository.login(email, password);
  }

  Future<Either<Failure, Map<String, dynamic>>> logOut() {
    return repository.logOut();
  }
}
