import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_sale_model.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';
import 'package:e_ticket/modules/tickets/domain/repository/ticket_sale_repository.dart';

class TicketSaleUsecase {
  final TicketSaleRepository ticketSaleRepository;
  TicketSaleUsecase(this.ticketSaleRepository);

  Future<Either<Failure, TicketsModel>> execute() {
    return ticketSaleRepository.getTicketList();
  }

  Future<Either<Failure, TicketSaleModel>> call(
      {required int userId, required int ticketRouteId, required int fromTicketCounterId, required int toTicketCounterId, required String type, required double price, required bool isAdvanced, required int deviceId, String? journeyDate}) {
    return ticketSaleRepository.callTicketSale(
      userId: userId,
      ticketRouteId: ticketRouteId,
      fromTicketCounterId: fromTicketCounterId,
      toTicketCounterId: toTicketCounterId,
      type: type,
      price: price,
      isAdvanced: isAdvanced,
      deviceId: deviceId,
      journeyDate: journeyDate!,
    );
  }
}
