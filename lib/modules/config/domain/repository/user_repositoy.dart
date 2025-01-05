import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';

import '../../data/models/users_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
}
