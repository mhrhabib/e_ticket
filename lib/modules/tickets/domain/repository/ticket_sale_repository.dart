import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_sale_model.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';

abstract class TicketSaleRepository {
  Future<Either<Failure, TicketsModel>> getTicketList();
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
  });
}
