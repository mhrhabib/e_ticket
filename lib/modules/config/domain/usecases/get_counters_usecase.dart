import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/counter_model.dart';
import 'package:e_ticket/modules/config/domain/repository/counter_repository.dart';

class GetCountersUsecase {
  final CounterRepository counterRepository;

  GetCountersUsecase(this.counterRepository);

  Future<Either<Failure, List<Counter>>> execute() {
    return counterRepository.getCounters();
  }
}
