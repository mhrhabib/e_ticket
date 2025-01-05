import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/counter_model.dart';

abstract class CounterRepository {
  Future<Either<Failure, List<Counter>>> getCounters();
}
