import 'package:e_ticket/modules/config/data/models/price_model.dart';

import '../repository/ticket_price_repository.dart';

class CalculateTicketPriceUseCase {
  final TicketPriceRepository repository;

  CalculateTicketPriceUseCase(this.repository);

  Future<PriceModel> call({
    required String userId,
    required String ticketRouteId,
    required String toCounterId,
    required String type,
  }) {
    return repository.calculateTicketPrice(
      userId: userId,
      ticketRouteId: ticketRouteId,
      toCounterId: toCounterId,
      type: type,
    );
  }
}
