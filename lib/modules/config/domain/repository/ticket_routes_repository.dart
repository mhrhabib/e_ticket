import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/ticket_routes_model.dart';

abstract class TicketRoutesRepository {
  Future<Either<Failure, List<TicketRoute>>> getTicketRoutes();
}
