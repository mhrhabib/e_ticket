import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/ticket_type_model.dart';

import '../repository/ticket_type_repository.dart';

class GetTicketTypeUsecase {
  final TicketTypesRepository ticketTypesRepository;

  GetTicketTypeUsecase(this.ticketTypesRepository);

  Future<Either<Failure, List<TicketType>>> execute() {
    return ticketTypesRepository.getTicketTypes();
  }
}
