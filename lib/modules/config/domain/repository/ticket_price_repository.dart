import 'package:e_ticket/modules/config/data/models/price_model.dart';

abstract class TicketPriceRepository {
  Future<PriceModel> calculateTicketPrice({
    required String userId,
    required String ticketRouteId,
    required String toCounterId,
    required String type,
  });
}
