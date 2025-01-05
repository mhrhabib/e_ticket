import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/datasources/config_remote_data_source.dart';
import 'package:e_ticket/modules/config/data/models/ticket_routes_model.dart';
import 'package:e_ticket/modules/config/domain/repository/ticket_routes_repository.dart';

class TicketRoutesRepositoryImpl extends TicketRoutesRepository {
  final ConfigRemoteDataSource configRemoteDataSource;

  TicketRoutesRepositoryImpl({required this.configRemoteDataSource});

  @override
  Future<Either<Failure, List<TicketRoute>>> getTicketRoutes() async {
    try {
      final response = await configRemoteDataSource.fetchTicketRoutes();
      return Right(response.data!);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
