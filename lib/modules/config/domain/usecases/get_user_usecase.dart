import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import '../../data/models/users_model.dart';
import '../repository/user_repositoy.dart';

class GetUsersUseCase {
  final UserRepository userRepository;

  GetUsersUseCase(this.userRepository);

  Future<Either<Failure, List<User>>> execute() {
    return userRepository.getUsers();
  }
}
