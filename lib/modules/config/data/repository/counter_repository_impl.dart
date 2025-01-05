import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/datasources/config_remote_data_source.dart';
import 'package:e_ticket/modules/config/data/models/counter_model.dart';
import 'package:e_ticket/modules/config/domain/repository/counter_repository.dart';

class CounterRepositoryImpl extends CounterRepository {
  final ConfigRemoteDataSource configRemoteDataSource;

  CounterRepositoryImpl(this.configRemoteDataSource);
  @override
  Future<Either<Failure, List<Counter>>> getCounters() async {
    try {
      final response = await configRemoteDataSource.fetchCounters();

      return Right(response.data!.data!);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
