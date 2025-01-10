import 'package:e_ticket/modules/tickets/data/service/local_data_service.dart';
import '../models/local_ticket_fare_model.dart';
import '../models/local_ticket_sale_model.dart';

abstract class TicketLocalDataSource {
  Future<void> saveTicketSalesLocally(List<LocalTicketSaleModel> sales);
  Future<List<LocalTicketSaleModel>> getTicketSalesLocally();
  Future<void> saveFareListLocally(List<LocalTicketFareModel> fares);
  Future<List<LocalTicketFareModel>> getFareListLocally();
}

class TicketLocalDataSourceImpl implements TicketLocalDataSource {
  final LocalDataService _localDataService = LocalDataService();

  @override
  Future<void> saveTicketSalesLocally(List<LocalTicketSaleModel> sales) async {
    await _localDataService.saveTicketSaleLocally(sales);
  }

  @override
  Future<List<LocalTicketSaleModel>> getTicketSalesLocally() async {
    return await _localDataService.getTicketSalesLocally();
  }

  @override
  Future<void> saveFareListLocally(List<LocalTicketFareModel> fares) async {
    await _localDataService.saveFareListLocally(fares);
  }

  @override
  Future<List<LocalTicketFareModel>> getFareListLocally() async {
    return await _localDataService.getFareListLocally();
  }
}
