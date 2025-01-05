import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/ticket_routes_model.dart';
import 'package:e_ticket/modules/config/domain/repository/ticket_routes_repository.dart';

class GetTicketRoutesUsecase {
  final TicketRoutesRepository ticketRoutesRepository;

  GetTicketRoutesUsecase(this.ticketRoutesRepository);

  Future<Either<Failure, List<TicketRoute>>> execute() {
    return ticketRoutesRepository.getTicketRoutes();
  }
}
