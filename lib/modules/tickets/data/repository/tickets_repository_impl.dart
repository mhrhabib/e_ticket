import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/datasource/ticket_remote_data_source.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_fare_model.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_sale_model.dart';
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

  @override
  Future<Either<Failure, TicketSaleModel>> callTicketSale({
    required int userId,
    required int ticketRouteId,
    required int fromTicketCounterId,
    required int toTicketCounterId,
    required String type,
    required double price,
    required bool isAdvanced,
    required int deviceId,
    String? journeyDate,
  }) async {
    try {
      final response = await ticketRemoteDataSource.addTicketSale(
          userId: userId, ticketRouteId: ticketRouteId, fromTicketCounterId: fromTicketCounterId, toTicketCounterId: toTicketCounterId, type: type, price: price, isAdvanced: isAdvanced, deviceId: deviceId, journeyDate: journeyDate!);

      return Right(response);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketFareModel>> getTicketFare() async {
    try {
      final response = await ticketRemoteDataSource.getTicketFare();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
