import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/datasource/ticket_remote_data_source.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';
import 'package:e_ticket/modules/tickets/domain/repository/ticket_sale_repository.dart';

class TicketsRepositoryImpl extends TicketSaleRepository {
  final TicketRemoteDataSource ticketRemoteDataSource;
  TicketsRepositoryImpl(this.ticketRemoteDataSource);

  @override
  Future<Either<Failure, TicketsModel>> getTicketList() async {
    try {
      final response = await ticketRemoteDataSource.getTicketsList();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
