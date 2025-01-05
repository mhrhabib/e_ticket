import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/ticket_type_model.dart';

abstract class TicketTypesRepository {
  Future<Either<Failure, List<TicketType>>> getTicketTypes();
}
