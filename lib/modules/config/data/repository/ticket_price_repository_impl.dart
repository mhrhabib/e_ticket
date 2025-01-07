import 'package:e_ticket/modules/config/data/datasources/config_remote_data_source.dart';
import 'package:e_ticket/modules/config/data/models/price_model.dart';

import '../../domain/repository/ticket_price_repository.dart';

class TicketPriceRepositoryImpl implements TicketPriceRepository {
  final ConfigRemoteDataSource remoteDataSource;

  TicketPriceRepositoryImpl(this.remoteDataSource);

  @override
  Future<PriceModel> calculateTicketPrice({
    required String userId,
    required String ticketRouteId,
    required String toCounterId,
    required String type,
  }) {
    return remoteDataSource.getTicketPrice(
      userId: userId,
      ticketRouteId: ticketRouteId,
      toCounterId: toCounterId,
      type: type,
    );
  }
}
