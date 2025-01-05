import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/datasources/config_remote_data_source.dart';
import 'package:e_ticket/modules/config/data/models/ticket_type_model.dart';
import 'package:e_ticket/modules/config/domain/repository/ticket_type_repository.dart';

class TicketTypeRepositoryImpl extends TicketTypesRepository {
  final ConfigRemoteDataSource configRemoteDataSource;
  TicketTypeRepositoryImpl(this.configRemoteDataSource);
  @override
  Future<Either<Failure, List<TicketType>>> getTicketTypes() async {
    try {
      final response = await configRemoteDataSource.fetchTicketTypes();
      return Right(response.data!);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
