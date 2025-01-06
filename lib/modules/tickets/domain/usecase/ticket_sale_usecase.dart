import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';
import 'package:e_ticket/modules/tickets/domain/repository/ticket_sale_repository.dart';

class TicketSaleUsecase {
  final TicketSaleRepository ticketSaleRepository;
  TicketSaleUsecase(this.ticketSaleRepository);

  Future<Either<Failure, TicketsModel>> execute() {
    return ticketSaleRepository.getTicketList();
  }
}
