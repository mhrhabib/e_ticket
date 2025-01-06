import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';

abstract class TicketSaleRepository {
  Future<Either<Failure, TicketsModel>> getTicketList();
}
